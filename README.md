# External_bromite-webview
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
- It is not necessary to remove the default webview repo from the build tree.

## Updating Packages
This branch does not include the packages. You need to download them from official website. Here's an example I 
found to simply download the latest packages for all supported architectures at once, as well as the checksum 
information (so you can validate them after download).

```
bash <(curl -s https://raw.githubusercontent.com/Jrchintu/external_bromite-webview/R11/update.sh)
```
