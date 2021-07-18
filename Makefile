IMAGE ?= squidfunk/mkdocs-material

serve:
	docker run --net=host --volume "$$(pwd)":"$$(pwd)" --workdir "$$(pwd)" -it $(IMAGE)

build:
	docker run --net=host --volume "$$(pwd)":"$$(pwd)" --workdir "$$(pwd)" -it $(IMAGE) build --clean
