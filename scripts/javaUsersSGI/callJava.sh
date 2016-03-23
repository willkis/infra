#!/bin/bash
export LANG=pt_PT.iso88591
cd /app/scripts/javaUsersSGI/
java -Xms128m -Xmx512m -XX:MaxPermSize=128m -jar /app/scripts/javaUsersSGI/UsersSGI.jar
