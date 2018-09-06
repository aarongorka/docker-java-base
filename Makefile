ifdef BUILD_ID
	GIT_SHA = $(shell git rev-parse HEAD | head -c 10)
	BUILD_VERSION = $(BUILD_ID)-$(GIT_SHA)
else
	BUILD_VERSION?=local
endif

IMAGE_NAME ?= nexus:18443/java-base

##################
# PUBLIC TARGETS #
##################
dockerBuild:
	docker build -t $(IMAGE_NAME):$(BUILD_VERSION) .

dockerPush:
	docker push $(IMAGE_NAME):$(BUILD_VERSION)

dockerPushLatest:
	docker pull $(IMAGE_NAME):$(BUILD_VERSION)
	docker tag $(IMAGE_NAME):$(BUILD_VERSION) $(IMAGE_NAME):latest
	docker push $(IMAGE_NAME):latest

nexusLogin:
	echo "$(NEXUS_PASSWORD)" | docker login https://nexus:18443 -u admin --password-stdin
