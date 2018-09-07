FROM alpine:latest as base
RUN adduser -D --system java && \
	apk add --update --no-cache openjdk8-jre
USER java

FROM base as builder
USER root
RUN apk add --no-cache maven openjdk8 procps
