FROM eclipse-temurin:11

ARG URL_GBIF_BACKBONE=https://hosted-datasets.gbif.org/datasets/backbone/current/backbone.zip
ARG URL_IRMNG=https://www.irmng.org/export/IRMNG_genera_DwCA.zip

ARG URL_NAMESDIST=https://nexus.ala.org.au/service/local/repositories/releases/content/au/org/ala/ala-name-matching-distribution/4.3/ala-name-matching-distribution-4.3-distribution.zip

RUN apt-get update && apt-get install -y wget unzip
WORKDIR /usr/lib/nameindexer

RUN mkdir -p /data/lucene/sources/IRMNG_DWC_HOMONYMS \
    && wget "$URL_IRMNG" -O /data/lucene/sources/IRMNG_DWC_HOMONYMS.zip \
    && unzip -u /data/lucene/sources/IRMNG_DWC_HOMONYMS.zip -d /data/lucene/sources/IRMNG_DWC_HOMONYMS \
    && rm /data/lucene/sources/IRMNG_DWC_HOMONYMS.zip

RUN mkdir -p /data/lucene/sources/backbone \
    && wget "$URL_GBIF_BACKBONE" -O /data/lucene/sources/backbone.zip \
    && unzip -u /data/lucene/sources/backbone.zip -d /data/lucene/sources/backbone \
    && rm /data/lucene/sources/backbone.zip \
    && mkdir -p /usr/lib/nameindexer \
    && wget "$URL_NAMESDIST" -O /usr/lib/nameindexer/ala-name-matching-distribution.zip \
    && unzip -u /usr/lib/nameindexer/ala-name-matching-distribution.zip -d /usr/lib/nameindexer \
    && rm /usr/lib/nameindexer/ala-name-matching-distribution.zip \
    && chmod +x /usr/lib/nameindexer/*.sh \
    && cd /usr/lib/nameindexer \
    && /usr/lib/nameindexer/index.sh --all --dwca /data/lucene/sources/backbone --target /data/lucene/namematching --irmng /data/lucene/sources/IRMNG_DWC_HOMONYMS/ \
    && rm -rf /data/lucene/sources/IRMNG_DWC_HOMONYMS /data/lucene/sources/backbone

VOLUME /data/lucene/namematching
