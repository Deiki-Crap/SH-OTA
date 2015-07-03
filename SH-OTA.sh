SH-OTA(){ # v2.1 By Deic, DiamondBond & hoholee12

	# Configuration
	version="version"
	cloud="https://your_site.com/version.sh"

	# Optional
	notes="
changelog or something
"
	# 0/1 = Disabled/Enabled
	show_notes="0"
	show_version="1"


	# Don't touch from here
	info=`if [ "$show_version" == 1 ]; then echo "$version; echo; elif [ "$show_notes" == 1 ]; then echo "$notes"; echo; fi`
	base_name=`basename $0`

	mount -o remount,rw rootfs
	mount -o remount,rw /system
	mount -o remount,rw /data
	mkdir -p /tmp/
	chmod 755 /tmp/

	if [ ! -f /system/xbin/curl ]; then
		clear
		echo "Curl binaries not found."
		sleep 1.5
		clear
		echo "Downloading curl binaries..."
		am start -a android.intent.action.VIEW -n com.android.browser/.BrowserActivity https://github.com/DeicPro/Download/releases/download/curl/curl.zip >/dev/null 2>&1
		sleep 10
		curl="1"
	fi

	if [ "$curl" == 1 ]; then
		while true; do
			if [ -f $EXTERNAL_STORAGE/download/curl.zip ]; then
				kill -9 $(pgrep com.android.browser)
				clear
				echo "Installing..."
				unzip -oq $EXTERNAL_STORAGE/download/curl.zip -d /tmp/
				break
			fi
		done

		while true; do
			if [ -f /tmp/curl ] && [ -f /tmp/openssl ] && [ -f /tmp/openssl.cnf ] && [ -f /tmp/ca-bundle.crt ]; then
				mkdir /data/local/ssl/
				mkdir /data/local/ssl/certs/
				cp -f /tmp/curl /system/xbin/
				cp -f /tmp/openssl /system/xbin/
				cp -f /tmp/openssl.cnf /data/local/ssl/
				cp -f /tmp/ca-bundle.crt /data/local/ssl/certs/
				sleep 2
				chmod -R 755 /system/xbin/
				chmod -R 755 /data/local/ssl/
				rm -f $EXTERNAL_STORAGE/download/curl.zip
				break
			fi
		done

		while true; do
			if [ -f /system/xbin/curl ] && [ -f /system/xbin/openssl ] && [ -f /data/local/ssl/openssl.cnf ] && [ -f /data/local/ssl/certs/ca-bundle.crt ]; then
				clear
				echo "Installed."
				sleep 1.5
				break
			fi
		done
	fi

	clear
	echo "Checking updates..."
	curl -k -L -o /tmp/version.sh $cloud 2>/dev/null

	while true; do
		if [ -f /tmp/version.sh ]; then
			if [ "`grep $version /tmp/version.sh 2>/dev/null`" ]; then
				clear
				echo "You have the latest version."
				sleep 1.5
				install="0"
				break
			else
				clear
				echo "A new version of the script was found..."
				echo
				$info
				echo "Want install it? (Y/N)"
				echo
				echo -n "> "
				read install_opt
				case $install_opt in
					y|Y )
						install="1"
						break
					;;
					n|N )
						install="0"
						break
					;;
					* )
						echo "Write [Y] or [N] and press enter..."
						sleep 1.5
					;;
				esac
			fi
		fi
	done

	if [ "$install"  == 1 ]; then
		clear
		echo "Downloading..."

		for script_cloud in $(grep cloud /tmp/version.sh | awk '{print $2}' ); do
			curl -k -L -o /tmp/$base_name $script_cloud 2>/dev/null
		done
	fi

	while true; do
		if [ "$install" == 0 ]; then
			clear
			break
		fi

		if [ -f /tmp/$base_name ]; then
			clear
			echo "Installing..."
			cp -f /tmp/$base_name $0
			sleep 2
			chmod 755 $0
			clear
			echo "Installed."
			sleep 1.5
			$SHELL -c $0
			clear
			exit
		fi
	done
}
SH-OTA
