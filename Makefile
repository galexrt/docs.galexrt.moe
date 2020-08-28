serve:
	docker run --volume "$$(pwd)":"$$(pwd)" --workdir "$$(pwd)" -it squidfunk/mkdocs-material
