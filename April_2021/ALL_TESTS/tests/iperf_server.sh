#!/bin/bash

start_iperf3_server () {
local test_name="iperf_server"
   
echo "iperf server with port $port just have been started"

local test_dir_suffix
test_dir_suffix="$custom_dir_suffix-$(date +%s)"

port="$1"

report_dir="$path/$port"
[ -f "$report_dir" ] || mkdir -p "$report_dir"

echo "Current test working directory is $report_dir"
    echo > "$report_dir/iperf_output-timestamp-$timestamp"

    iperf3 --server --interval 0.5 --port "$port" --verbose --logfile "$report_dir/iperf_output-timestamp-$timestamp" &
    
}
