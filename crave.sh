#!/bin/bash

rm -rf .repo/local_manifests/
# Cleanup to fix SyncErrors raised during branch checkouts
rm -rf platform/prebuilts
rm -rf prebuilts
# Upgrade System
sudo apt update && sudo apt upgrade -y

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
# Set LD_LIBRARY_PATH (libgcc_s.so.1 linker)

mkdir -p /usr/bin/../lib/gcc/x86_64-linux-gnu/11
cp /usr/bin/../lib/gcc/x86_64-linux-gnu/* /usr/bin/../lib/gcc/x86_64-linux-gnu/11/*

# Temp fix: Remove Seedvault

rm -rf external/seedvault
export BUILD_USERNAME=keosh1
export BUILD_HOSTNAME=crave
# Sync the repositories
/opt/crave/resync.sh
echo "============================"
source build/envsetup.sh
curl https://raw.githubusercontent.com/keosh1/local_manifests/refs/heads/a15/repopicks.sh | bash

#build the rom
lunch yaap_mondrian-userdebug
make installclean
m yaap
