FROM joostlaan/meteord:base
MAINTAINER MeteorHacks Pvt Ltd.

ONBUILD COPY ./ /app
ONBUILD RUN bash $METEORD_DIR/dist_build.sh
