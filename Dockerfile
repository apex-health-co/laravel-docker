FROM ubuntu:latest
LABEL authors="dcumb"

ENTRYPOINT ["top", "-b"]