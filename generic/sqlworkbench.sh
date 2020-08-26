#!/bin/sh

SETUP_DIR=/opt/sqlworkbench
TEMP_FILE=/tmp/sqlworkbench.zip

curl -o $TEMP_FILE https://www.sql-workbench.eu/Workbench-Build127-with-optional-libs.zip
if [ -d "$SETUP_DIR" ]; then rm -Rf $SETUP_DIR; fi
mkdir -p $SETUP_DIR
mkdir -p /usr/local/bin
mkdir -p /usr/local/share/applications
unzip -d $SETUP_DIR/ $TEMP_FILE
chmod +x /opt/sqlworkbench/sql*.sh
ln -s /opt/sqlworkbench/sqlwbconsole.sh /usr/local/bin/
ln -s /opt/sqlworkbench/sqlworkbench.sh /usr/local/bin/

cat << EOF > /usr/local/share/applications/sqlworkbench.desktop
[Desktop Entry]
Version=1.0
Name=SQL Workbench/J
Comment=Free, DBMS-independent, cross-platform SQL query tool
Categories=Development;Utility;Database;
Exec=/opt/sqlworkbench/sqlworkbench.sh
Icon=/opt/sqlworkbench/workbench32.png
Terminal=false
Type=Application
EOF

rm $TEMP_FILE
