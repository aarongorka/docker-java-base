# docker-java-base

## Why?

This image aims to provide a secure and hardened environment to run Java applications.

Features:
  * Jenkins pipeline for building the Docker image
  * Automatic builds for the latest security updates
  * Builder container for [multistage] or [builder container pattern]
  * Vulnerability scanning
  * A minimal base image to reduce attack surface and external dependencies
  * Uses the [3 Musketeers] methodology (Docker, docker-compose and make) for a simple and portable pipeline

[3 Musketeers]: https://3musketeers.io/
[multistage]: https://docs.docker.com/develop/develop-images/multistage-build/
[builder container pattern]: https://medium.com/@alexeiled/docker-pattern-the-build-container-b0d0e86ad601

## How To Use?

Your Docker container will be built with a two-stage process: the first stage builds the JAR file, the second stage builds the Docker image.

In your downstream application, your initial stage will use `nexus:18443/java-base-builder:latest` and is responsible for outputting a JAR file using maven.

A second stage will be based on `nexus:18443/java-base:latest` and consume this JAR file, creating a Docker image that is deployed to all environments as an immutable artifact. This image will be lightweight and contains no build tools or other unnecessary dependencies.

Your downstream app will be automatically triggered whenever this Docker image is rebuilt, ensuring it always has the latest security updates.

## Examples

Dockerfile:
```Dockerfile
FROM nexus:18443/java-base-builder:latest as builder
WORKDIR /srv/app

# download dependencies first to cache them in a Docker layer, only rebuilds if pom.xml is modified
COPY pom.xml /srv/app/
RUN mvn verify clean --fail-never

COPY . /srv/app
RUN mvn clean install

FROM nexus:18443/java-base:latest
VOLUME /tmp
COPY --from=builder /srv/app/target/cicd-demo-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT [ "java","-Djava.security.egd=file:/dev/./unrandom","-jar","/app.jar" ]
```

Jenkinsfile:
```Groovy
pipeline {
  triggers { upstream(upstreamProjects: 'docker-java-base/master', threshold: hudson.model.Result.SUCCESS) }
// ...
}
```

## Branching Strategy

`master` is considered the [trunk] branch. Only images from this branch are tagged with `latest` and are used by downstream applications as a base.

Feature branches can be created for testing purposes, but they will never be tagged with `latest`.

[trunk]: https://trunkbaseddevelopment.com/
