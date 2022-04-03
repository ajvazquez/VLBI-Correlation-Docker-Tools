# References:
# - https://www.atnf.csiro.au/vlbi/dokuwiki/doku.php/difx/installation

ARG DIFXREPO=https://svn.atnf.csiro.au/difx/master_tags/DiFX-2.6.2
ARG SVN_OPTS="--trust-server-cert --non-interactive"
ARG DFP=/usr/local/difx
ARG DIFXIOB=$DFP/difxio_build
ARG DIFXDRL=$DFP/dirlist_build
ARG V2D=$DFP/vex2difx_build


FROM debian:stretch-slim as v2d_builder
RUN apt-get update && apt-get install -y \
    automake \
    autotools-dev \
    bison \
    build-essential \
    flex \
	gcc \
    libexpat-dev \
    libgsl-dev \
    libfftw3-dev \
    libtool \
    pkg-config \
	subversion

ARG DIFXREPO
ARG SVN_OPTS
ARG DFP
ARG DIFXIOB
ARG V2D
ARG DIFXDRL=$DFP/dirlist_build
ARG DIFXMSG=$DFP/difxmessage_build
ARG PKG_CONFIG_PATH=$DIFXIOB/lib/pkgconfig:$DIFXMSG/lib/pkgconfig:$DIFXDRL/lib/pkgconfig

# Clone vex2difx and dependencies
WORKDIR $DFP
RUN svn co $DIFXREPO/libraries/difxio $SVN_OPTS && \
    svn co $DIFXREPO/libraries/difxmessage $SVN_OPTS && \
    svn co $DIFXREPO/libraries/dirlist $SVN_OPTS && \
    svn co $DIFXREPO/applications/vex2difx $SVN_OPTS


# Build dirlist
WORKDIR $DFP/dirlist
RUN aclocal && \
    libtoolize --copy --force && \
    autoconf && \
    autoheader && \
    automake -a -c
RUN mkdir -p $DIFXDRL && \
    ./configure --prefix=$DIFXDRL && \
    make && \
    make install

# Build difxmessage
WORKDIR $DFP/difxmessage
RUN aclocal && \
    libtoolize --copy --force && \
    autoconf && \
    autoheader && \
    automake -a -c
RUN mkdir -p $DIFXMSG && \
    ./configure --prefix=$DIFXMSG && \
    make && \
    make install


# Build difxio
WORKDIR $DFP/difxio
RUN aclocal && \
    libtoolize --copy --force && \
    autoconf && \
    autoheader && \
    automake -a -c
RUN mkdir -p $DIFXIOB && \
    ./configure --prefix=$DIFXIOB && \
    make && \
    make install


# Build vex2difx
WORKDIR $DFP/vex2difx
RUN pkg-config --cflags difxio difxmessage && \
    aclocal && \
    libtoolize --copy --force && \
    autoconf && \
    autoheader && \
    automake -a
RUN ./configure --prefix=$V2D && \
    make && \
    make install


# Target system
FROM debian:stretch-slim
ARG DFP
ARG DIFXIOB
ARG DIFXDRL
ARG V2D
ARG LIB=/usr/lib/x86_64-linux-gnu
COPY --from=v2d_builder $DIFXIOB $DIFXIOB
COPY --from=v2d_builder $DIFXDRL $DIFXDRL
COPY --from=v2d_builder $V2D $V2D
COPY --from=v2d_builder $LIB/libfftw3.so.3 $LIB/
COPY --from=v2d_builder $LIB/libgsl.so.19 $LIB/
COPY --from=v2d_builder $LIB/libgslcblas.so.0 $LIB/
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$DIFXIOB/lib
ENV PATH=$PATH:$V2D/bin
ENV DIFX_VERSION=2.6.2


# Entrypoint
COPY ctx/run_v.sh /usr/local/
RUN chmod +x /usr/local/run_v.sh
USER 1000
CMD ["/usr/local/run_v.sh"]
