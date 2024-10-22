#!/bin/bash

rm -rf .repo/local_manifests/
#A15 source repo
repo init -u https://github.com/LineageOS/android.git -b lineage-22.0 --git-lfs
# Rom source repo
repo init -u https://github.com/yaap/manifest.git -b fifteen --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Clone local_manifests repository
git clone https://github.com/keosh1/local_manifests.git --depth 1 -b a15 .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Sync the repositories
/opt/crave/resync.sh
echo "============================"
source build/envsetup.sh
curl https://raw.githubusercontent.com/keosh1/local_manifests/refs/heads/a15/repopicks.sh | bash

#build the rom
lunch yaap_mondrian-userdebug
m yaap
