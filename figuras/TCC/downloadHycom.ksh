#!/bin/ksh

idate=$1
fdate=$2

north=$3
south=$4
east=$5
west=$6

date --date="$idate 00:00:00" +%s | read i
date --date="$fdate 00:00:00" +%s | read j

(( i -= 10800 ))
(( j -= 10800 ))

dt=86400

while (( $j >= $i )); do

      date -d "1970-01-01 00:00:00 $i sec" "+%Y%m%d%H" | read d

      echo $d | cut -c1-4  | read yyyy
      echo $d | cut -c5-6  | read mm
      echo $d | cut -c7-8  | read dd

      file=$7_${yyyy}${mm}${dd}.nc

      wget -O $file "http://ncss.hycom.org/thredds/ncss/GLBu0.08/expt_19.1/${yyyy}?var=salinity&var=water_temp&north=${north}&west=${west}&east=${east}&south=${south}&disableLLSubset=on&disableProjSubset=on&horizStride=1&time_start=${yyyy}-${mm}-${dd}T00%3A00%3A00Z&time_end=${yyyy}-${mm}-${dd}T00%3A00%3A00Z&timeStride=1&vertCoord=&accept=netcdf"
      echo $file >> err.log

      (( i += $dt ))
done
