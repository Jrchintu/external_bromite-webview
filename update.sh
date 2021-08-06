#!/bin/env bash

## CONFIG
git config --global user.name "jrchintu"
git config --global user.email "harrypetersun@gmail.com"
git config --global credential.helper store
echo "https://jrchintu:$GIT_PASS@github.com" >~/.git-credentials

## CLONE
git clone --depth=1 https://github.com/Jrchintu/external_bromite-webview.git -b R11 DEADDIR && cd DEADDIR || exit
curl -s https://api.github.com/repos/bromite/bromite/releases/latest |
    grep "_SystemWebView\\.apk\|brm.*txt" | cut -d : -f 2,3 | tr -d \" | wget -qi -
rm -rf ./*txt*

## CHECK
SHAOLD1="$(sha256sum prebuilt/arm64/SystemWebView.apk)"
SHAOLD2="$(sha256sum prebuilt/x86/SystemWebView.apk)"
SHAOLD3="$(sha256sum prebuilt/arm/SystemWebView.apk)"
SHANEW1="$(sha256sum ./arm64_SystemWebView.apk)"
SHANEW2="$(sha256sum ./x86_SystemWebView.apk)"
SHANEW3="$(sha256sum ./arm_SystemWebView.apk)"

if
    [ "$SHAOLD1" != "$SHANEW1" ]
    [ "$SHAOLD2" != "$SHANEW2" ]
    [ "$SHAOLD3" != "$SHANEW3" ]
then
    echo "NO LATEST UPDATE FOUND CHECKSUM IS SAME"
    rm -rvf ./*apk*
else
    echo "LATEST UPDATE FOUND. UPDATING BINARY"
    mv arm64_* prebuilt/arm64/SystemWebView.apk
    mv x86_* prebuilt/x86/SystemWebView.apk
    mv arm_* prebuilt/arm/SystemWebView.apk
    git add -A
    git commit -sa -m "Update $(TZ=Asia/Kolkata date)"
    git push
    rm -rvf ./*apk*
fi

## CLEAN
cd .. && rm -rf DEADDIR
rm -rf ~/.git-credentials
