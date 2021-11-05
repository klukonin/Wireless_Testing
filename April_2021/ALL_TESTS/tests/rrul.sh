#!/bin/bash

make_test_rrul() {
local test_name="rrul"

# Getting device ID

current_device_id="$host"

echo "RRUL test was started"

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
test_filename=$(ls "$data_dir/rrul"*)


flent --input="$test_filename" --plot=download --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"download.png

flent --input="$test_filename" --plot=download_scaled --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"download_scaled.png

flent --input="$test_filename" --plot=upload --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"upload.png

flent --input="$test_filename" --plot=upload_scaled --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"upload_scaled.png

flent --input="$test_filename" --plot=ping_scaled --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"ping_scaled.png

flent --input="$test_filename" --plot=ping_cdf --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"ping_cdf.png

flent --input="$test_filename" --plot=icmp_cdf --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"icmp_cdf.png

flent --input="$test_filename" --plot=totals_bandwidth --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"totals_bandwidth.png

flent --input="$test_filename" --plot=totals --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"totals.png

flent --input="$test_filename" --plot=totals_scaled --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"totals_scaled.png

flent --input="$test_filename" --plot=all_scaled --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"all_scaled.png

flent --input="$test_filename" --plot=all --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"all.png

flent --input="$test_filename" --plot=box_download --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"box_download.png

flent --input="$test_filename" --plot=box_upload --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"box_upload.png

flent --input="$test_filename" --plot=box_ping --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"box_ping.png

flent --input="$test_filename" --plot=box_totals --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"box_totals.png

flent --input="$test_filename" --plot=icmp_combine --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"icmp_combine.png

flent --input="$test_filename" --plot=box_combine --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"box_combine.png

flent --input="$test_filename" --plot=box_combine_up --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"box_combine_up.png

flent --input="$test_filename" --plot=box_combine_down --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"box_combine_down.png

flent --input="$test_filename" --plot=bar_combine_up --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"bar_combine_up.png

flent --input="$test_filename" --plot=bar_combine_down --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"bar_combine_down.png

flent --input="$test_filename" --plot=ellipsis --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"ellipsis.png

flent --input="$test_filename" --plot=ellipsis_down --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"ellipsis_down.png

flent --input="$test_filename" --plot=ellipsis_sum --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"ellipsis_sum.png

flent --input="$test_filename" --plot=tcp_cwnd --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"tcp_cwnd.png

flent --input="$test_filename" --plot=tcp_rtt --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"tcp_rtt.png

flent --input="$test_filename" --plot=tcp_rtt_cdf --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"tcp_rtt_cdf.png

flent --input="$test_filename" --plot=tcp_rtt_box_combine --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"tcp_rtt_box_combine.png

flent --input="$test_filename" --plot=tcp_rtt_bar_combine --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"tcp_rtt_bar_combine.png

flent --input="$test_filename" --plot=tcp_pacing --bounds-x="$length" --figure-width="$plot_width" --figure-height="$plot_height" --output="$data_dir/"tcp_pacing.png

}
