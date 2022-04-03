# References:
# - https://www.atnf.csiro.au/vlbi/dokuwiki/doku.php/difx/installation

ARG DIFXREPO=https://svn.atnf.csiro.au/difx/master_tags/DiFX-2.6.2
ARG SVN_OPTS="--trust-server-cert --non-interactive"
ARG DFP=/usr/local/difx
ARG CAL=$DFP/difxcalc11_build


# Base system
FROM debian:stretch-slim as calc_builder
RUN apt-get update && apt-get install -y \
    automake \
    autotools-dev \
    build-essential \
    gfortran \
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
ARG CAL

# Clone difxcalc
RUN mkdir -p $DFP
WORKDIR $DFP
RUN svn co $DIFXREPO/applications/difxcalc11 $SVN_OPTS

WORKDIR $DFP/difxcalc11
RUN aclocal && \
    autoconf && \
    automake -a
RUN ./configure --prefix=$CAL && \
    make && \
    make install

# Target system
FROM debian:stretch-slim
ARG CAL
ARG LIB=/usr/lib/x86_64-linux-gnu
COPY --from=calc_builder $CAL $CAL
COPY --from=calc_builder $LIB/libgsl.so.19 $LIB/
COPY --from=calc_builder $LIB/libgslcblas.so.0 $LIB/
COPY --from=calc_builder $LIB/libgfortran.so.3 $LIB/
COPY --from=calc_builder $LIB/libquadmath.so.0 $LIB/
ENV PATH=$PATH:$CAL/bin


# Entrypoint
COPY ctx/run_c.sh /usr/local/
RUN chmod +x /usr/local/run_c.sh
USER 1000
CMD ["/usr/local/run_c.sh"]
