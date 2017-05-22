#!/bin/bash
todate=$(date -d "00:00 2017/05/22" +%s)
startdate=$(date -d "00:00 2017/05/21" +%s)
newdate=$startdate
echo $newdate
echo $todate
echo $(($todate-$newdate))
#space after [ and before ] is needed
while [ $todate -ge $newdate ]
do
    str=$(date -u -d @$newdate +'%Y%m%d_%H%M')
    source="https://#sourcestorageaccount.blob.core.windows.net/#sourcecontainer/"
    dest="https://#deststorageaccount.blob.core.windows.net/#destcontainer/"
    echo $source
    echo $dest
    echo $str
    rm ./testdata/*
    azcopy  --source $source --include "testprefix$str" --source-key "#sourcekey" --destination ./testdata

    azcopy --source ./testdata --include "testprefix$str" --destination $dest --dest-key "#destkey"

    newdate=$((newdate+3600))
done

