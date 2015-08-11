#!/bin/bash
set -e

bash $METEORD_DIR/lib/install_jshint_csslint.sh
bash $METEORD_DIR/lib/install_meteor.sh
bash $METEORD_DIR/lib/build_app.sh
