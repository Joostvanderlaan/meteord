FROM joostlaan/meteord:base
MAINTAINER MeteorHacks Pvt Ltd.

ONBUILD COPY ./ /app
ONBUILD RUN bash $METEORD_DIR/test_build.sh
