#!/bin/bash
set -e

source "build/envsetup.sh";
source "vendor/lineage/build/envsetup.sh";

# hardware/qcom-caf/sm8450/audio/primary-hal
changes=(
405881 # hal: Guard primary audio HAL in case target provides prebuilt
)
repopick -f -P hardware/qcom-caf/sm8450/audio/primary-hal ${changes[@]}&

# hardware/xiaomi
changes=(
405259 # fingerprint: Move UDFPS handler and extension out of HIDL
404720 # aidl: fingerprint: Initial stub service
404721 # aidl: fingerprint: Initial Xiaomi implementation
)
repopick -f -P hardware/xiaomi ${changes[@]}&

# vendor/lineage
changes=(
367044 # android: merge_dtbs: Respect miboard-id while merging
)
repopick -f -P vendor/lineage ${changes[@]}&

wait

wget https://raw.githubusercontent.com/luk1337/lineageos-rootdir/refs/heads/lineage-22.0/picks
wget https://raw.githubusercontent.com/luk1337/lineageos-rootdir/refs/heads/lineage-22.0/gen_chain
chmod +x picks
chmod +x gen_chain
bash ./picks
rm picks gen_chain
