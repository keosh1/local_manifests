crave run  --no-patch -- "rm -rf .repo/local_manifests; \
repo init -u https://github.com/LineageOS/android.git -b lineage-22.0 --git-lfs; \
repo sync; \
repo init -u https://github.com/yaap/manifest.git -b fifteen --git-lfs; \
repo sync -j$(nproc --all) --no-tags --no-clone-bundle --fifteen; \
git clone https://github.com/keosh1/local_manifests.git --depth 1 -b a15 .repo/local_manifests; \
/opt/crave/resync.sh; \
source build/envsetup.sh; \
curl https://raw.githubusercontent.com/keosh1/local_manifests/refs/heads/a15/repopicks.sh | bash; \
lunch yaap_mondrian-userdebug; \ 
m yaap;
