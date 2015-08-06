#!/bin/bash
set -e

jshint .
csslint .
#meteor run --test
