#! make

build:
	@docker build --no-cache -t biodiversitydata-se/ala-name-matching-index .

run:
	@docker run --rm -it biodiversitydata-se/ala-name-matching-index bash

release:
	@./make-release.sh
