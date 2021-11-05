#!/bin/bash

make_test_bursts_11e() {
local test_name="bursts_11e"

# Getting device ID

current_device_id="$host"

echo "TCP_BIDIRECTIONAL test was started"

local test_dir_suffix
test_dir_suffix="$custom_dir_suffix-$(date +%s)"

local report_dir="$1/$current_device_id"
local data_dir="$1/$current_device_id/test_data/$test_name-$test_dir_suffix"
local length="$2"
current_test_data_dir="$data_dir"

echo "Current test working directory is $current_test_data_dir"

[ -n "$length" ] || local length="$test_length" #Getting global value
mkdir -p "$data_dir"
mkdir -p "$report_dir"

    #Flush directory before test
    rm -rf "${data_dir:?}"/*
           
    flent "$test_name" --swap-up-down --data-dir="$data_dir" --output="$data_dir/netperf_output" --length="$length" --step-size=0.1 --host="$host" --extended-metadata --socket-stats --title-extra="EvilWireless wifi $test_name test for $host"
    
#Wait for file with test results
sleep 2
test_filename=$(ls "$data_dir/$test_name"*)


flent --input="$test_filename" --plot=tcp_rtt_bar_combine --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"tcp_rtt_bar_combine.png

flent --input="$test_filename" --plot=tcp_rtt_box_combine --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"tcp_rtt_box_combine.png

flent --input="$test_filename" --plot=ping --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"ping.png

flent --input="$test_filename" --plot=tcp_rtt --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"tcp_rtt.png

flent --input="$test_filename" --plot=tcp_rtt_cdf --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"tcp_rtt_cdf.png

}
