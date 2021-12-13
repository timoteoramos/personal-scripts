#!/bin/sh

SETUP_DIR=/usr/local/share/java
TEMP_FOLDER=/tmp

wget -O $TEMP_FOLDER/jaybird-4.0.4.java11.zip https://github.com/FirebirdSQL/jaybird/releases/download/v4.0.4/jaybird-4.0.4.java11.zip
wget -O $TEMP_FOLDER/jconn3.jar.zip http://www.java2s.com/Code/JarDownload/jconn3/jconn3.jar.zip
wget -O $TEMP_FOLDER/sqljdbc4-3.0.jar.zip http://www.java2s.com/Code/JarDownload/sqljdbc4/sqljdbc4-3.0.jar.zip

mkdir -p $SETUP_DIR
unzip -d $SETUP_DIR/ $TEMP_FOLDER/jaybird-4.0.4.java11.zip jaybird-full-4.0.4.java11.jar
unzip -d $SETUP_DIR/ $TEMP_FOLDER/jconn3.jar.zip
unzip -d $SETUP_DIR/ $TEMP_FOLDER/sqljdbc4-3.0.jar.zip

rm $TEMP_FOLDER/jaybird-4.0.4.java11.zip
rm $TEMP_FOLDER/jconn3.jar.zip
rm $TEMP_FOLDER/sqljdbc4-3.0.jar.zip
