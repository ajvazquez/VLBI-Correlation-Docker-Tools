# References:
# - https://www.haystack.mit.edu/wp-content/uploads/2020/07/docs_hops_000_vgos-data-processing.pdf


#ARG C_HOPS_VERSION=3.9
#ARG C_HOPS_REVISION=835
#ARG C_HOPS_VERSION=3.20
#ARG C_HOPS_REVISION=2790
ARG C_HOPS_VERSION=3.21
ARG C_HOPS_REVISION=2936
ARG C_TARFILE=hops-$C_HOPS_VERSION-$C_HOPS_REVISION.tar.gz
ARG C_HOPS=ftp://gemini.haystack.mit.edu/pub/hops/$C_TARFILE
ARG C_PGPLOT=ftp://ftp.astro.caltech.edu/pub/pgplot/pgplot5.2.tar.gz
ARG HDIR=/usr/local/hops
ARG PGPLOT_DIR=/usr/local/pgplot


# Base system
FROM debian:stretch-slim as hops_builder
RUN apt-get update && \
    apt-get install -y \
    bash \
    bc \
    build-essential \
	gcc \
	gfortran \
	ghostscript \
	ghostscript-x \
	libfftw3-dev \
    libpng-dev \
	libx11-dev \
	nginx \
	pkg-config \
	supervisor \
	vim \
	wget \
	zlib1g-dev

# Env
ARG C_HOPS_VERSION
ARG C_HOPS_REVISION
ARG C_TARFILE
ARG C_HOPS
ARG C_PGPLOT
ARG PGPLOT_DIR
ARG HDIR

# pgplot
WORKDIR /usr/local/src/
RUN wget $C_PGPLOT && \
    tar -xzf `basename $C_PGPLOT` && \
    mkdir -p /usr/local/pgplot
COPY ctx/drivers.list /usr/local/pgplot/drivers.list_extra
RUN cat /usr/local/pgplot/drivers.list_extra >> /usr/local/pgplot/drivers.list && \
    echo "" >> /usr/local/pgplot/drivers.list
WORKDIR $PGPLOT_DIR
RUN /usr/local/src/pgplot/makemake /usr/local/src/pgplot linux g77_gcc && \
    sed -i -e 's/FCOMPL=g77/FCOMPL=gfortran/g' ./makefile && \
    make && \
    make cpg && \
    make clean

# hops
RUN mkdir -p /usr/local/hops_src/
WORKDIR /usr/local/hops_src
RUN wget $C_HOPS && \
    tar -xzf ./$C_TARFILE && \
    rm ./$C_TARFILE && \
    mkdir build

# correlator string
ARG MKSTR
RUN find . -name '*.c' -exec sed -ir "s@Mk4/DiFX@Mk4/$MKSTR@g" {} \;

WORKDIR /usr/local/hops_src/build
RUN ../hops-$C_HOPS_VERSION/configure \
	--enable-hopes --prefix=$HDIR \
	PNG12_LIB='/usr/lib/x86_64-linux-gnu/libpng.so' && \
	make && \
    make install
#RUN rm -r $HDIR/share/hops/testdata

# Target system
FROM debian:stretch-slim
RUN apt-get update && \
    apt-get install -y \
    ghostscript \
    ghostscript-x && \
    rm -r /var/lib/apt/*
ARG C_HOPS
ARG HDIR
ARG PGPLOT_DIR
ENV PGPLOT_DIR=$PGPLOT_DIR
ENV PGPLOT_DEV=/XSERVE
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PGPLOT_DIR
COPY --from=hops_builder $HDIR $HDIR
COPY --from=hops_builder $PGPLOT_DIR $PGPLOT_DIR
ARG LIB=/usr/lib/x86_64-linux-gnu
COPY --from=hops_builder $LIB/libgfortran.so.3 $LIB/
COPY --from=hops_builder $LIB/libpng16.so.16 $LIB/
COPY --from=hops_builder $LIB/libX11.so.6 $LIB/
COPY --from=hops_builder $LIB/libXau.so.6 $LIB/
COPY --from=hops_builder $LIB/libXdmcp.so.6 $LIB/
COPY --from=hops_builder $LIB/libquadmath.so.0 $LIB/
COPY --from=hops_builder $LIB/libxcb.so.1 $LIB/
COPY --from=hops_builder $LIB/libfftw3.so.3 $LIB/
ARG LIB=/lib/x86_64-linux-gnu
COPY --from=hops_builder $LIB/libbsd.so.0 $LIB/
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$DIFXIOB/lib

# test
RUN $PGPLOT_DIR/pgdemo1

# env
RUN /bin/bash -c 'source /usr/local/hops/bin/hops.bash'
RUN cat /usr/local/hops/bin/hops.bash
ENV PATH="/usr/local/hops/bin:$PATH"
ENV PROGDOC=/usr/local/hops/share/hops/vhelp
COPY ctx/control_file.txt /usr/local/hops/
ARG PFORMAT=/correlator/prog/text/
RUN mkdir -p $PFORMAT
COPY --from=hops_builder /usr/local/hops_src/hops*/sub/vex/text/*.txt $PFORMAT/
ENV DEF_CONTROL="/usr/local/hops/control_file.txt"
COPY ctx/run_ff.sh /usr/local/hops/
RUN chmod +x /usr/local/hops/run_ff.sh

USER 1000
#RUN apt-get update && apt-get install -y x11-apps
CMD ["/usr/local/hops/run_ff.sh"]
