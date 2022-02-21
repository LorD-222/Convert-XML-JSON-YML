#!/bin/bash
sourceprefix=
if [[ -d programs/internet/xidel/ ]]; then sourceprefix=programs/internet/xidel/; else sourceprefix=./;  fi
mkdir -p /usr/bin
install -v $sourceprefix/xidel /usr/bin

cp ./yq_linux_amd64 /usr/bin/yq
chmod +x /usr/bin/yq

for file in "$@"
do
xidel  -s $file -e '{|//Configuration/{@* :{|Variable/{@* :text()}|}}|}' > $file.json
cat $file.json | yq e -P > $file.yml
done

# unite
# yq eval-all '. as $item ireduce ({}; . *+ $item)' file2.yml file1.yml > anotherFile.yml