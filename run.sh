#!/bin/sh

export DISPLAY=:1
Xvfb :1 -screen 0 1024x768x24 &

java -jar /opt/selenium-server-standalone-$SELENIUM_VERSION.jar -port 4444
