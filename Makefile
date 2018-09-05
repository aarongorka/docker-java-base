ifdef BUILD_ID
	GIT_SHA = $(shell git rev-parse HEAD | head -c 5)
	BUILD_VERSION = $(BUILD_ID)-$(GIT_SHA)
else
	BUILD_VERSION?=local
endif

IMAGE_NAME ?= localhost:18443/java-base

##################
# PUBLIC TARGETS #
##################
dockerBuild:
	docker build -t $(IMAGE_NAME):$(BUILD_VERSION) .
	docker tag $(IMAGE_NAME):$(BUILD_VERSION) $(IMAGE_NAME):latest

dockerPush:
	docker push $(IMAGE_NAME):$(BUILD_VERSION)
	docker push $(IMAGE_NAME):latest

###########
# ENVFILE #
###########
# Create .env based on .env.template if .env does not exist
.env:
	@echo "Create .env with .env.template"
	cp .env.template .env

# Create/Overwrite .env with $(DOTENV)
dotenv:
	@echo "Overwrite .env with $(DOTENV)"
	cp $(DOTENV) .env

$(DOTENV):
	$(info overwriting .env file with $(DOTENV))
	cp $(DOTENV) .env
.PHONY: $(DOTENV)
