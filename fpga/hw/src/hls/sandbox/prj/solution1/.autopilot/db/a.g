#!/bin/sh
lli=${LLVMINTERP-lli}
exec $lli \
    /home/jdanner3/VIP/repos/vip/fpga/hw/src/hls/sandbox/prj/solution1/.autopilot/db/a.g.bc ${1+"$@"}
