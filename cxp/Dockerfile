# References:
# - https://github.com/ajvazquez/CXS338

ARG CX_REPO=https://github.com/ajvazquez/CXS338.git@master

FROM python:3.8-slim-bullseye as cxp_builder
RUN apt-get update && apt-get install -y gcc git
ARG CX_REPO

# CX w/o pyspark
WORKDIR /opt/cx
COPY ctx/requirements.min.txt /tmp/
RUN python3 -m venv venv3 && \
    venv3/bin/pip install -r /tmp/requirements.min.txt && \
    venv3/bin/pip install --no-deps -e git+$CX_REPO#egg=CXS338

# Jupyterlab
RUN venv3/bin/pip install jupyterlab

FROM python:3.8-slim-bullseye
COPY --from=cxp_builder /opt/cx /opt/cx
COPY ctx/run_cxp.sh /opt/cx/

RUN mkdir -p /.local && chown -R 1000:1000 /.local

RUN chmod +x /opt/cx/run_cxp.sh
USER 1000
CMD ["/opt/cx/run_cxp.sh"]
