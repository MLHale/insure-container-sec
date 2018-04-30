#!/bin/sh
bldred='\033[1;31m'
bldgrn='\033[1;32m'
bldblu='\033[1;34m'
bldylw='\033[1;33m' # Yellow
txtrst='\033[0m'

logit () {
  printf "%b\n" "$1" | tee -a "$logger"
}

info () {
  printf "%b\n" "${bldblu}[INFO]${txtrst} $1" | tee -a "$logger"
}

pass () {
  printf "%b\n" "${bldgrn}[PASS]${txtrst} $1" | tee -a "$logger"
}

warn () {
  printf "%b\n" "${bldred}[WARN]${txtrst} $1" | tee -a "$logger"
}

note () {
  printf "%b\n" "${bldylw}[NOTE]${txtrst} $1" | tee -a "$logger"
}

yell () {
  printf "%b\n" "${bldylw}$1${txtrst}\n"
}

beginjson () {
  printf "{\n  \"dockerbenchsecurity\": \"%s\",\n  \"start\": %s," "$1" "$2" | tee "$logger.json" 2>/dev/null 1>&2
}

endjson (){
  printf "\n  \"end\": %s \n}\n" "$1" | tee -a "$logger.json" 2>/dev/null 1>&2
}

logjson (){
  printf "\n  \"%s\": \"%s\"," "$1" "$2" | tee -a "$logger.json" 2>/dev/null 1>&2
}

integerjson (){
  printf "\n  \"%s\": %s," "$1" "$2" | tee -a "$logger.json" 2>/dev/null 1>&2
}
