# References:
# - https://www.atnf.csiro.au/vlbi/dokuwiki/doku.php/difx/installation

ARG DIFXREPO=https://svn.atnf.csiro.au/difx/master_tags/DiFX-2.6.2
ARG SVN_OPTS=" --trust-server-cert --non-interactive"
ARG DFP=/usr/local/difx
ARG DIFXIOB=$DFP/difxio_build
ARG D2M=$DFP/difx2mark4_build
ARG PKG_CONFIG_PATH=$DIFXIOB/lib/pkgconfig


# Base system
FROM debian:stretch-slim as d2m_builder
RUN apt-get update && apt-get install -y \
    automake \
    autotools-dev \
    build-essential \
    pkg-config \
    libgsl-dev \
    libfftw3-dev \
    libtool \
	gcc \
	subversion

# Env
ARG DIFXREPO
ARG SVN_OPTS
ARG DFP
ARG DIFXIOB
ARG D2M
ARG PKG_CONFIG_PATH

# Clone difx2mark4 and dependencies
WORKDIR $DFP
RUN svn co $DIFXREPO/libraries/difxio $SVN_OPTS && \
    svn co $DIFXREPO/applications/difx2mark4 $SVN_OPTS

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

# Build difx2mark4
WORKDIR $DFP/difx2mark4
RUN pkg-config --cflags difxio && \
    aclocal && \
    autoconf && \
    autoheader && \
    automake -a
RUN ./configure --prefix=$D2M && \
    make && \
    make install


# Target system
FROM debian:stretch-slim
ARG DFP
ARG DIFXIOB
ARG D2M
ARG LIB=/usr/lib/x86_64-linux-gnu
COPY --from=d2m_builder $DIFXIOB $DIFXIOB
COPY --from=d2m_builder $D2M $D2M
COPY --from=d2m_builder $LIB/libfftw3.so.3 $LIB/
COPY --from=d2m_builder $LIB/libgsl.so.19 $LIB/
COPY --from=d2m_builder $LIB/libgslcblas.so.0 $LIB/
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$DIFXIOB/lib
ENV PATH=$PATH:$D2M/bin


# Entrypoint
COPY ctx/run_d.sh /usr/local/
RUN chmod +x /usr/local/run_d.sh
USER 1000
CMD ["/usr/local/run_d.sh"]
