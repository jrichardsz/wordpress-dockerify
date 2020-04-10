#!/bin/bash
set -e

function start {
  source /etc/apache2/envvars
  exec apache2 -DFOREGROUND
}

start
