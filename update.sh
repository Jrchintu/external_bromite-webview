#!/bin/bash
git clone --depth=1 git@github.com:Jrchintu/external_bromite-webview.git -b R11 data && cd data2 || exit
curl -s https://api.github.com/repos/bromite/bromite/releases/latest \
| grep "_SystemWebView\\.apk\|brm.*txt" | cut -d : -f 2,3 | tr -d \" | wget -qi -
rm -rf ./*txt*
mv arm64_* prebuilt/arm64/SystemWebView.apk
mv x86_* prebuilt/x86/SystemWebView.apk
mv arm_* prebuilt/arm/SystemWebView.apk
git add .
git commit -s -m "Update apk $(date)"
git push
cd .. && rm -rf data2
