#!/bin/bash
docker build --rm . -t hops:latest
# Set correlation string (Mk4/*)
docker build --build-arg MKSTR=CXS338 --rm . -t hops-cxs:latest
