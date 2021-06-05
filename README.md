# android_external_bromite-webview
Prebuilt Android System Webview from www.bromite.org

Replaces the default Android System Webview with the 'Bromite' SystemWebView component in Custom ROM builds

## Credits
I have only taken the apk files (arm, arm64, x86) from https://www.bromite.org/system_web_view  and created an 'Androik.mk' file around. 
All credits go to the Chromium project (https://www.chromium.org/Home) and the developers behind Bromite. Please visit the 
respective pages listed above for more information and the respective Copyright and License

## How to include into your Custom ROM build
- Include this repo into your local manifest (path does not matter, suggest external/bromite-webview)
- Download latest packages from [official website](https://www.bromite.org/system_web_view), verify the file 
integrity, then place the downloaded binaries of respective architectures to their designated locations.
- Specify `PRODUCT_PACKAGES += bromite-webview` in a 'product' .mk file (**not** in an Android.mk file)
- An 'elegant' way to do so without having to fork and track any specific device or vendor repository is to simply 
create an own product.mk file in directory vendor/extras (or to add the above statement into an existing one)
- It is not necessary to remove the default webview repo from the build tree

## Downloading Packages
This branch does not include the packages. You need to download them from official website. Here's an example I 
found to simply download the latest packages for all supported architectures at once, as well as the checksum 
information (so you can validate them after download).

```
#!/bin/sh
git clone git@github.com:Jrchintu/android_external_bromite-webview-nb.git -b master data
cd data/prebuilt || exit
curl -s https://api.github.com/repos/bromite/bromite/releases/latest \
| grep "_SystemWebView\\.apk\|brm.*txt" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi -
mv arm64_* arm64
mv x86_* x86
mv arm_* arm
for d in ./*/ ; do (rm -rf *txt* && cd "$d" && rm -rf *txt*); done
cd ..
git add .
git commit -s
git push
```

After validating their integrity, move the packages to the designated locations. The designated locations 
for System WebView packages are:

- `arm_SystemWebView.apk` goes to `prebuilt/arm/SystemWebView.apk`.
- `arm64_SystemWebView.apk` goes to `prebuilt/arm64/SystemWebView.apk`.
- `x86_SystemWebView.apk` goes to `prebuilt/x86/SystemWebView.apk`.
