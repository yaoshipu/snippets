#!/bin/bash

shopt -s extglob
set -o errtrace
set -o errexit

log()  { printf "%b\n" "$*"; }
fail() { log "\nERROR: $*\n" ; exit 1 ; }

download_binary(){

  log "Downloading binaries from Qiniu ..."

  URL_PREFIX=http://7xp7mc.dl1.z0.glb.clouddn.com/golang/tools/bin/

  FILES=( "go-outline" "go-symbols" "gocode" "godef" "goimports" "golint" "gopkgs" "gorename" "goreturns" "guru" )

  for file in "${FILES[@]}"
  do
	log "Downloading: $file"
    curl -so $1/$file $URL_PREFIX$file
    chmod +x $1/$file
  done
}

install(){
  DEFAULT_PATH="/usr/local/bin"
  read -p "Choose path to install go tools binary? [Default: $DEFAULT_PATH ] " TOOL_PATH
  TOOL_PATH=${TOOL_PATH:-$DEFAULT_PATH}

  download_binary $TOOL_PATH

  log "Go tools succesfully installed"
  log 'Please export $PATH=$PATH:'$TOOL_PATH
}

install