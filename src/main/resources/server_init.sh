#!/bin/bash

main_class=com.jyall.ServerInit
if [ $# -lt 1 ]; then
    echo "Usage ${0} server_conf_path"
    exit 1
 fi

PRG="$0"

while [ -h "$PRG" ]; do
  ls=`ls -ld "$PRG"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    PRG="$link"
  else
    PRG=`dirname "$PRG"`/"$link"
  fi
done

# Get standard environment variables
PRGDIR=`dirname "$PRG"`

server_home=`cd "$PRGDIR/.." >/dev/null; pwd`


for i in `ls ${server_home}/lib/ | sort -rf`
do
    server_class_path=$server_class_path:${server_home}/lib/$i
done
export CLASSPATH=${server_class_path}
server_ip=$(ifconfig | grep -e "inet:" -e "addr:" | grep -v "inet6" | grep -v "127.0.0.1" | head -n 1 | awk '{print $2}' | cut -c6-)
echo "server_ip=${server_ip}"
java ${main_class} $1 $server_ip