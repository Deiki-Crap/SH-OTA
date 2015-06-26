#SH-OTA v1.2_alpha By Deic

sh-ota(){
#Edit values
name="your_script.sh"
version="version"
location="/system/xbin"
cloud="https://your_site.com/ota.sh"

#Don't edit
ext="$EXTERNAL_STORAGE/Download"
tmp="/data/local/tmp"; xbin="/system/xbin"; ssl="/data/local/ssl"
curl_cloud="https://github.com/DeicPro/Download/releases/download/curl"
start_browser="am start -a android.intent.action.VIEW -n com.android.browser/.BrowserActivity $curl_cloud"

mount -o remount,rw /system; mount -o remount,rw /data

clear
if [ ! -f $xbin/curl ]; then
echo "Curl binaries not found."; echo
clear; echo "Downloading curl binaries..."; sleep 1

$start_browser/curl.file >/dev/null 2>&1; $start_browser/openssl.file >/dev/null 2>&1
$start_browser/openssl_cnf.file >/dev/null 2>&1; $start_browser/ca-bundle_crt.file >/dev/null 2>&1
curl="1"
if

if [ "$curl" == 1 ]; then
while true; do
if [ -f $ext/curl.file ] && [ -f $ext/openssl.file ] && [ -f $ext/openssl_cnf.file ] && [ -f $ext/ca-bundle_crt.file ]; then
clear; echo; echo "Installing..."; sleep 1

am force-stop com.android.browser; mkdir -p $ssl/; mkdir -p $ssl/certs/
rm -f $ext/curl.file $xbin/curl; rm -f $ext/openssl.file $xbin/openssl
rm -f $ext/openssl_cnf.file $ssl/openssl.cnf; rm -f $ext/ca-bundle_crt.file $ssl/certs/ca-bundle.crt
cp -f $ext/curl.file; cp -f $ext/openssl.file
cp -f $ext/openssl_cnf.file; cp -f $ext/ca-bundle_crt.file
chmod 755 $ssl/; chmod 755 $ssl/certs/; chmod 755 $xbin/curl
chmod 755 $xbin/openssl; chmod 755 $ssl/openssl.cnf; chmod 755 $ssl/certs/ca-bundle.crt

echo; echo "Done.";sleep 1; download
fi
done
fi

if [ ! "$curl" ]
clear; echo "Checking updates..."; sleep 1

curl -k -L -o $tmp/ota.sh $cloud >/dev/null 2>&1

while true; do
if [ -f $tmp/ota.sh ]; then
chmod 755 $tmp/ota.sh; $tmp/ota.sh; break
fi
done
fi

while true; do
if [ -f $tmp/$name ]; then
echo; echo "Installing..."; sleep 1

cp -f $tmp/$name $location/$name; rm -f $tmp/$name; chmod 755 $location/$name

echo; echo "Installed."; sleep 1

mount -o remount,ro /system 2>/dev/null; mount -o remount,ro /data 2>/dev/null

$location/$name; clear; exit
fi
done
}

sh-ota
