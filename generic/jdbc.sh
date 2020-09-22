#!/bin/sh

SETUP_DIR=/usr/local/share/java
TEMP_FOLDER=/tmp

wget -O $TEMP_FOLDER/Jaybird-3.0.9-JDK_1.8.zip https://github.com/FirebirdSQL/jaybird/releases/download/v3.0.9/Jaybird-3.0.9-JDK_1.8.zip
wget -O $TEMP_FOLDER/jconn3.jar.zip http://www.java2s.com/Code/JarDownload/jconn3/jconn3.jar.zip
wget -O $TEMP_FOLDER/sqljdbc4-3.0.jar.zip http://www.java2s.com/Code/JarDownload/sqljdbc4/sqljdbc4-3.0.jar.zip

mkdir -p $SETUP_DIR
unzip -d $SETUP_DIR/ $TEMP_FOLDER/Jaybird-3.0.9-JDK_1.8.zip jaybird-full-3.0.9.jar
unzip -d $SETUP_DIR/ $TEMP_FOLDER/jconn3.jar.zip
unzip -d $SETUP_DIR/ $TEMP_FOLDER/sqljdbc4-3.0.jar.zip

rm $TEMP_FOLDER/Jaybird-3.0.9-JDK_1.8.zip
rm $TEMP_FOLDER/jconn3.jar.zip
rm $TEMP_FOLDER/sqljdbc4-3.0.jar.zip
