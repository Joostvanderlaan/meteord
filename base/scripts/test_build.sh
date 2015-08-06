#!/bin/bash
set -e

bash $METEORD_DIR/lib/install_meteor.sh
bash $METEORD_DIR/lib/install_jshint.sh
bash $METEORD_DIR/lib/build_app.sh
bash $METEORD_DIR/lib/run_tests.sh
