#!/bin/bash

# set -x # Only for debug

#Headers gonna head
. ./wifi_test_core


#########################################################################################
#Testing parameters overrides


test_length=120
#########################################################################################



#########################################################################################
#Testing process code

# Making tcp_4down test. Testing directory full path should be passed as an argument
make_test_tcp_4down "$test_results_dir" $test_length

# Making tcp_4up test. Testing directory full path should be passed as an argument
make_test_tcp_4up "$test_results_dir" $test_length

# Making tcp_bidirectional test. Testing directory full path should be passed as an argument
make_test_tcp_bidirectional "$test_results_dir" $test_length

# Making RRUL test. Testing directory full path should be passed as an argument 
make_test_rrul "$test_results_dir" $test_length

# Making RTT FAIR test. Testing directory full path should be passed as an argument
make_test_rtt_fair_var_mixed "$test_results_dir" $test_length

# Making 802.11e BURTSS test. Testing directory full path should be passed as an argument
#make_test_bursts_11e "$test_results_dir" $test_length

