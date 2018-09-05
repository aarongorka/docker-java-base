# Using a public base image, can be improved by using `FROM scratch` and adding Alpine rootfs e.g. https://github.com/gliderlabs/docker-alpine/tree/2bfe6510ee31d86cfeb2f37587f4cf866f28ffbc/builder
FROM openjdk:8-jre-alpine
RUN adduser -D --system java
USER java
