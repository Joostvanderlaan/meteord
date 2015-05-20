FROM meteorhacks/meteord:base
MAINTAINER MeteorHacks Pvt Ltd.

ENV VULCANIZE=true

ONBUILD COPY ./ /app
ONBUILD RUN bash $METEORD_DIR/on_build.sh
