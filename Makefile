#! make

build:
	@docker build --no-cache -t ghcr.io/biodiversitydata-se/ala-name-matching-index:1.0.1 .

run:
	@docker run --rm -it ghcr.io/biodiversitydata-se/ala-name-matching-index:1.0.1 bash

release:
	@./make-release.sh
