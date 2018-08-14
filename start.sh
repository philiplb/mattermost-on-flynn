#!/bin/bash

export MM_ServiceSettings_ListenAddress=$PORT

python createConfig.py

TYPE=${TYPE:-"team"}
VERSION=${VERSION:-"5.1.1"}
FILE=mattermost-$TYPE-$VERSION-linux-amd64.tar.gz
URL=https://releases.mattermost.com/$VERSION/$FILE

echo "Downloading $URL"
wget $URL

tar -zxf $FILE

mattermost/bin/platform --config=config.json
