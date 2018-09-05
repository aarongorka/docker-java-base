# Using a public base image, can be improved by using `FROM scratch` and adding Alpine rootfs e.g. https://github.com/gliderlabs/docker-alpine/tree/2bfe6510ee31d86cfeb2f37587f4cf866f28ffbc/builder
FROM alpine:latest
RUN adduser -D --system java && \
	apk add --update --no-cache openjdk8-jre
USER java
