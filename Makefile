export CONTAINER_EXECUTABLE ?= docker
export CONTAINER_NETWORK ?= localci

GIT_TAG = $(shell git tag --points-at HEAD | tail -n 1)

.PHONY: pipeline pipeline-with-publish tag-pipeline reformat readme upgrade-test-lock

pipeline:
	./run-pipeline.sh branch

pipeline-with-publish:
	./run-pipeline.sh branch --with-publish

tag-pipeline:
	./run-pipeline.sh tag $(GIT_TAG)

reformat readme:
	./run-local-task.sh $@

upgrade-test-lock:
	DOCKER_DEFAULT_PLATFORM=linux/amd64 ./run-local-task.sh upgrade-test-lock
	DOCKER_DEFAULT_PLATFORM=linux/arm64 ./run-local-task.sh upgrade-test-lock

