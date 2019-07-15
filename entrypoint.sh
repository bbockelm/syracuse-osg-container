#!/bin/sh

cd /tmp
export _CONDOR_SCRATCH_DIR=$PWD
exec syracuse_glidein_startup.sh
