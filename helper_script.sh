#!/usr/bin/env bash

# a ripoff of my existing one, no logs, bad directory structure,
# it's only a PoC anyway

echo "omyega script running ε=ε=┌( >_<)┘"

# move everything we need to pack into the archive in a single directory
mkdir release

cp release-readme.txt release/readme.txt
cp LICENSE release/
cp SomeAssembly/bin/Release/net10.0/SomeAssembly.dll release/
cp SomeAssembly/bin/Release/net10.0/SomeAssembly.runtimeconfig.json release/

# figure out the release version
last_version=$(git tag --list 'v*' | colrm 1 1 | sort --numeric-sort --reverse | head --lines=1)
# with some extra code for the first one
last_version=${last_version:-0}

new_version=$(( "$last_version" + 1 ))
# also store it for later release creation i guess
echo $new_version > new-version

archive_name="le-release-$(printf "%02d" $new_version).zip"

# cd for clean relative names
cd release || exit 2
zip -r "../$archive_name" ./*

# just show it in the log "prominently" so it can be compared with actual release assets,
# and also store to put into release notes
sum=$(sha256sum SomeAssembly.dll)
echo "=== dll's sha256 ==="
echo "$sum"
echo "$sum" > checksums
