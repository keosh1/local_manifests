#!/bin/bash

rm -rf .repo/local_manifests/
repo init -u https://github.com/RisingTechOSS/android.git -b fourteen --git-lfs --depth=1 
git clone https://github.com/keosh1/local_manifests.git --depth 1 -b arian .repo/local_manifests
/opt/crave/resync.sh
# Set up build environment
export BUILD_USERNAME=keosh1 
export BUILD_HOSTNAME=crave 
source build/envsetup.sh
source vendor/lineage/build/envsetup.sh
repopick -g https://review.lineageos.org -P vendor/lineage 367044
repopick -g https://review.lineageos.org -P hardware/qcom-caf/sm8450/audio/primary-hal 405881
repopick -g https://review.lineageos.org -P hardware/qcom-caf/sm8450/display 397275
riseup mondrian userdebug
make installclean
rise b
