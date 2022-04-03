# References:
# - https://github.com/ajvazquez/CXS338

ARG CX_REPO=https://github.com/ajvazquez/CXS338.git@master

FROM bitnami/spark as cxs_builder
#FROM apache/spark:v3.2.1
USER root
RUN apt-get update && apt-get install -y gcc git #bitnami
#RUN apt-get update && apt-get install -y gcc git python3 python3-dev python3-venv #apache/spark
WORKDIR /opt/cx

ARG CX_REPO
RUN python3 -m venv venv3 && \
    venv3/bin/pip install -e git+$CX_REPO#egg=CXS338

FROM bitnami/spark
USER root
COPY --from=cxs_builder /opt/cx /opt/cx
COPY ctx/run_cxs.sh /opt/cx/
RUN chmod +x /opt/cx/run_cxs.sh
USER 1000

CMD ["/opt/cx/run_cxs.sh"]
