#!/usr/bin/env bash
#author Alan Turing
#date 2020.04
#fetures: install jdk

yum -y install java

echo "export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.242.b08-0.el7_7.x86_64" >> /etc/profile
echo "export PATH=$PATH:$JAVA_HOME" >> /etc/profile

