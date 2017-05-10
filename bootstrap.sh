#!/bin/bash

mainDir=cs350-work
srcDir=cs350-work/src

if [ ${HOME:0:3} == "/u/" ]; then
  #University of Waterloo server
  srcDir=cs350-os161
else

fi

while getopts "c" opt; do
    case "$opt" in
    # clean install
    c)  mkdir -p cs350-work/src
        cd cs350-work
        ;;
    esac
done

if [[ ! -x ./$srcDir ]]; then
  mkdir -p $srcDir
  # get OS161
  wget https://www.student.cs.uwaterloo.ca/~cs350/os161_repository/os161.tar.gz -O os161.tar.gz
  tar -xzf os161.tar.gz
  rm os161.tar.gz
fi

if [[ ! -f ./$srcDir/build-and-run-kernel.sh ]]; then
  # get useful processing scripts
  wget https://raw.githubusercontent.com/andrewparadi/docker-os161/master/build-and-run-kernel.sh -O ./src/build-and-run-kernel.sh
  chmod +x ./$srcDir/build-and-run-kernel.sh
fi

if [[ ! -f ./$srcDir/submit.sh ]]; then
  # get useful submission script
  wget https://raw.githubusercontent.com/andrewparadi/docker-os161/master/submit.sh -O ./src/submit
  chmod +x ./$srcDir/submit.sh
fi

if [ ! ${HOME:0:3} == "/u/" ]; then
  if [[ ! -f ./Makefile ]]; then
    # get useful makefile
    cd ..
    wget https://raw.githubusercontent.com/andrewparadi/docker-os161/master/Makefile -O Makefile
  fi
  # get the prebuilt Docker image
  docker pull andrewparadi/os161:latest
fi