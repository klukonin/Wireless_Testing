#!/bin/bash

set -x # Only for debug

# Minimal port is 5200. Maximum port is 5220.
# 

help="
This script is for mass network performance manual testing.
Some features are hardcoded.
Use argumans to set test parameters.
-p    Path of the testig directory.
-d    delay before testing willbe stopped and all imformation will be plotted.
-t    Name of the test (eg. 802dot11AX_HIGHLOAD).
-s    Sequence of the test (eg. 1,2,3,etc).
-h    Echo this help"


while getopts "p:d:t:s:" opt; do
    case $opt in
        p) path=$OPTARG ;;
        d) delay=$OPTARG ;;
        t) testname=$OPTARG ;;
        s) sequence=$OPTARG ;;
        h) echo "$help" ;;
        help) echo "$help" ;;
    esac
done

#Headers gonna head

. ./tests/iperf_server.sh

#########################################################################################
#Testing parameters overrides

timestamp=$(date +%s)

#########################################################################################

device_5200=""
device_5201="Dell Latitude ax200"
device_5202="Surface Pro 7"
device_5203="Samsung S10"
device_5204=""
device_5205=""
device_5206="Dell xps 15 ax200"
device_5207="Samsung S10e"
device_5208="Dell Latitude NO ax"
device_5209="ROG phone 3"
device_5210="Galaxy S10e"
device_5211=""
device_5212="iphone 11"
device_5213="Lenovo Thinkpad G2"
device_5214="Dell Latitude 5490"
device_5215=""
device_5216="Huawei P40"
device_5217=""
device_5218=""
device_5219=""
device_5220=""

#########################################################################################
#Testing process code

[ -f "$path" ] || mkdir -p "$path" 

killall -KILL iperf3

for port in $(seq 5200 5220) ; do

    # Making iperf3 server instance 
    start_iperf3_server "$port"

done

sleep $delay

 mkdir -p "$path/$testname-$sequence"
 
 for port in $(seq 5200 5220) ; do

    mv "$path/$port" "$path/$testname-$sequence"
    
done

path="$path/$testname-$sequence"

# Creating new csv file for plot

printf "" > "$path"/combined_csv



# Clean empty files 
for dir in $(seq 5200 5220) ; do


    if [ -e "$path/$dir" ] ; then
    
        file=$(ls "$path/$dir"/iperf*)
        filesize=$(stat -c%s "$file")
        
        if [ "$filesize" -lt 500 ] ; then
        
            rm -rf "{$path:?}/$dir"
        
        fi
    
    fi


done


# Make summary and header
for dir in $(seq 5200 5220) ; do

    if [ -e "$path/$dir" ] ; then
    
        file=$(ls "$path/$dir"/iperf*)
        
        cat "$file" | grep 'SUM' >> "$path/$dir"/SUM
        
        printf "%s," "$dir" >> "$path"/combined_csv
    
    fi

done
printf "SUM,\n" >> "$path"/combined_csv


# Fill combined CSV with values  
for line in $(seq 10 240) ; do

    SUMMARY=0
    for dir in $(seq 5200 5220) ; do

        if [ -e "$path/$dir" ] ; then
        
            speed=$(awk "NR==$line {printf \$6}" < "$path/$dir"/SUM)
            
            # Possible values are Gbits/sec, Mbits/sec, Kbits/sec, bits/sec
            value=$(awk "NR==$line {printf \$7}" < "$path/$dir"/SUM)
            
            case $value in
            
                "Gbits/sec")
                
                    speed=$(echo "$speed" | awk '{printf "%.2f", $1 * 1000}')
                ;;
                
                "Mbits/sec")
                
                    speed="$speed"
                ;;
                
                "Kbits/sec")
                
                    speed=$(echo "$speed" | awk '{printf "%.2f", $1 / 1000}')
                ;;
                
                "bits/sec")
                
                    speed=$(echo "$speed" | awk '{printf "%.2f", $1 / 1000000}')
                ;;
            
            esac
            
            if [ -n "$speed" ] ; then
            
            printf "%s," "$speed" >> "$path"/combined_csv
            SUMMARY=$(echo "$SUMMARY $speed" | awk '{printf "%.2f", $1 + $2}')
            
            else 
            
                printf "0.00," >> "$path"/combined_csv
            
            fi
        
        fi

    done
    
    printf "%s,\n" "$SUMMARY" >> "$path"/combined_csv
    
done


    
# Clear last commas before newline symbol
mv "$path"/combined_csv "$path"/combined_csv.broken
sed -z 's/,\n/\n/g' "$path"/combined_csv.broken > "$path"/combined_csv
rm "$path"/combined_csv.broken

# Replace port number with devices name. TODO: Need refactoring with a loop method

[ -n "$device_5200" ] && sed -i "s/5200/${device_5200}/g" "$path"/combined_csv
[ -n "$device_5201" ] && sed -i "s/5201/${device_5201}/g" "$path"/combined_csv
[ -n "$device_5202" ] && sed -i "s/5202/${device_5202}/g" "$path"/combined_csv
[ -n "$device_5203" ] && sed -i "s/5203/${device_5203}/g" "$path"/combined_csv
[ -n "$device_5204" ] && sed -i "s/5204/${device_5204}/g" "$path"/combined_csv
[ -n "$device_5205" ] && sed -i "s/5205/${device_5205}/g" "$path"/combined_csv
[ -n "$device_5206" ] && sed -i "s/5206/${device_5206}/g" "$path"/combined_csv
[ -n "$device_5207" ] && sed -i "s/5207/${device_5207}/g" "$path"/combined_csv
[ -n "$device_5208" ] && sed -i "s/5208/${device_5208}/g" "$path"/combined_csv
[ -n "$device_5209" ] && sed -i "s/5209/${device_5209}/g" "$path"/combined_csv
[ -n "$device_5210" ] && sed -i "s/5210/${device_5210}/g" "$path"/combined_csv
[ -n "$device_5211" ] && sed -i "s/5211/${device_5211}/g" "$path"/combined_csv
[ -n "$device_5212" ] && sed -i "s/5212/${device_5212}/g" "$path"/combined_csv
[ -n "$device_5213" ] && sed -i "s/5213/${device_5213}/g" "$path"/combined_csv
[ -n "$device_5214" ] && sed -i "s/5214/${device_5214}/g" "$path"/combined_csv
[ -n "$device_5215" ] && sed -i "s/5215/${device_5215}/g" "$path"/combined_csv
[ -n "$device_5216" ] && sed -i "s/5216/${device_5216}/g" "$path"/combined_csv
[ -n "$device_5217" ] && sed -i "s/5217/${device_5217}/g" "$path"/combined_csv
[ -n "$device_5218" ] && sed -i "s/5218/${device_5218}/g" "$path"/combined_csv
[ -n "$device_5219" ] && sed -i "s/5219/${device_5219}/g" "$path"/combined_csv
[ -n "$device_5220" ] && sed -i "s/5220/${device_5220}/g" "$path"/combined_csv

# Plot summarized result
echo "set key outside
set ylabel \"MBits/s\"
set datafile separator \",\"
set terminal png large size 1920,1080
set output \"$path/combined_plot.png\"
plot for [col=1:21] \"$path/combined_csv\" using 0:col with lines title columnheader" > "$path/plot_script"

gnuplot "$path/plot_script" > /dev/null 2>&1

rm "$path/plot_script"
