# docs.galexrt.moe

This work is licensed under the [Creative Commons Attribution 4.0 International License](https://creativecommons.org/licenses/by-sa/4.0/).

## Development

### Previewing The Site

To preview the side, you need to have `docker` installed:

```console
$ make serve
docker run --net=host --volume "$(pwd)":"$(pwd)" --workdir "$(pwd)" -it squidfunk/mkdocs-material
Unable to find image 'squidfunk/mkdocs-material:latest' locally
latest: Pulling from squidfunk/mkdocs-material
[...]
Digest: sha256:e6d9cbe3b377b792e2d104172daf84a3b3323b68b61c741cb69ff3cc52a2458e
Status: Downloaded newer image for squidfunk/mkdocs-material:latest
INFO     -  Building documentation...
[...]
INFO     -  Cleaning site directory
INFO     -  Documentation built in 5.42 seconds
INFO     -  [11:00:51] Serving on http://0.0.0.0:8000/
```

To stop the site preview, use <kbd>Ctrl</kbd> + <kbd>C</kbd>`

### Building The Site

```console
$ make build
docker run --net=host --volume "$(pwd)":"$(pwd)" --workdir "$(pwd)" -it squidfunk/mkdocs-material build --clean
INFO     -  Cleaning site directory
INFO     -  Building documentation to directory: /home/atrost/Projects/github.com/galexrt/docs.galexrt.moe/site
INFO     -  Documentation built in 5.41 seconds
$ # Site has been built.
```

This will build the page and output it to the `site/` directory.
