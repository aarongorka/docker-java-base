# docker-java-base

## Why?

This image aims to provide a secure and hardened environment to run Java applications.

Features:
  * Jenkins pipeline for building the Docker image
  * Automatic builds for the latest security updates
  * Vulnerability scanning
  * A minimal base image to reduce attack surface and external dependencies
  * Uses the [3 Musketeers] methodology (Docker, docker-compose and make) for a simple and portable pipeline

[3 Musketeers]: https://3musketeers.io/

## How To Use?

In your downstream application, point your Dockerfile to the `nexus:18443/java-base:latest`, and update your Jenkins pipeline to build your application whenever there is an update to it.

## Examples

Dockerfile:
```Dockerfile
FROM nexus:18443/java-base:latest
VOLUME /tmp
ARG JAR_FILE
COPY target/cicd-demo-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT [ "java","-Djava.security.egd=file:/dev/./unrandom","-jar","/app.jar" ]
```

Jenkinsfile:
```Groovy
pipeline {
  triggers { upstream(upstreamProjects: 'docker-java-base', threshold: hudson.model.Result.SUCCESS) }
// ...
}
```

## Branching Strategy

`master` is considered the [trunk] branch. Only images from this branch are tagged with `latest` and are used by downstream applications as a base.

Feature branches can be created for testing purposes, but they will never be tagged with `latest`.

[trunk]: https://trunkbaseddevelopment.com/
