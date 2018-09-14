#!/bin/bash

TYPE=${TYPE:-"team"}
VERSION=${VERSION:-"5.3.0"}
FILE=mattermost-$TYPE-$VERSION-linux-amd64.tar.gz
URL=https://releases.mattermost.com/$VERSION/$FILE
echo "Downloading $URL"
wget $URL

tar -zxf $FILE
rm $FILE

export MM_ServiceSettings_ListenAddress="\":$PORT\""
export MM_SqlSettings_DriverName=${MM_SqlSettings_DriverName:-"\"postgres\""}
export MM_SqlSettings_DataSource=${MM_SqlSettings_DataSource:-"\""$DATABASE_URL?sslmode=disable&connect_timeout=10"\""}
python createConfig.py

cd mattermost
bin/mattermost --config=../config.json
