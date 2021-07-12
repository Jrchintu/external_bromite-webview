#!/bin/bash

## CONFIG
git config --global user.name "jrchintu"
git config --global user.email "harrypetersun@gmail.com"
git config --global credential.helper store
echo "https://jrchintu:$GIT_PASS@github.com" > ~/.git-credentials

git clone --depth=1 https://github.com/Jrchintu/external_bromite-webview.git -b R11 DEADDIR && cd DEADDIR || exit
curl -s https://api.github.com/repos/bromite/bromite/releases/latest \
| grep "_SystemWebView\\.apk\|brm.*txt" | cut -d : -f 2,3 | tr -d \" | wget -qi -
rm -rf ./*txt*
mv arm64_* prebuilt/arm64/SystemWebView.apk
mv x86_* prebuilt/x86/SystemWebView.apk
mv arm_* prebuilt/arm/SystemWebView.apk
git commit -sam "Update $(TZ=Asia/Kolkata date)"
git push
cd .. && rm -rf DEADDIR
