#!/bin/sh

## setup command:
## wget https://github.com/emilnabil/xmlupdatebyiet5/raw/refs/heads/main/xmlupdatebyiet5.sh -O - | /bin/sh

echo "Download and install plugin xmlupdatebyiet5"
################################################################################
MY_URL="https://github.com/emilnabil/xmlupdatebyiet5/raw/refs/heads/main"
MY_IPK="enigma2-plugin-extensions-xmlupdatebyiet5_all.ipk"
MY_DEB="enigma2-plugin-extensions-xmlupdatebyiet5_all.deb"
TMP_DIR="/tmp"
################################################################################

# remove old plugin #
echo "Removing old plugin..."
opkg remove --force-depends enigma2-plugin-extensions-xmlupdatebyiet5 >/dev/null 2>&1
rm -rf /usr/lib/enigma2/python/Plugins/Extensions/XMLupdatebyiet5 >/dev/null 2>&1
echo "Old plugin removed successfully"

################################################################################

# Download and install plugin #
echo "Downloading and installing plugin..."
cd "$TMP_DIR" || exit 1

INSTALL_RESULT=1

if command -v dpkg >/dev/null 2>&1; then
    # DreamOS (.deb)
    echo "Detected .deb based system"
    wget -q -O "$MY_DEB" "$MY_URL/$MY_DEB"
    if [ -f "$MY_DEB" ]; then
        dpkg -i --force-overwrite "$MY_DEB"
        INSTALL_RESULT=$?
        rm -f "$MY_DEB"
    else
        echo "Error: Failed to download .deb package"
    fi
else
    # opkg (.ipk)
    echo "Detected .ipk based system"
    wget -q -O "$MY_IPK" "$MY_URL/$MY_IPK"
    if [ -f "$MY_IPK" ]; then
        opkg install --force-overwrite "$MY_IPK"
        INSTALL_RESULT=$?
        rm -f "$MY_IPK"
    else
        echo "Error: Failed to download .ipk package"
    fi
fi

echo "================================="

if [ "$INSTALL_RESULT" -eq 0 ]; then
    echo ">>>> SUCCESSFULLY INSTALLED <<<<"
    echo "********************************************************************************"
    echo "UPLOADED BY >>> EMIL_NABIL"
    sleep 2
    echo "Restarting Enigma2..."

    if command -v systemctl >/dev/null 2>&1; then
        systemctl restart enigma2
    else
        killall -9 enigma2 >/dev/null 2>&1
    fi
else
    echo ">>>> INSTALLATION FAILED! <<<<"
    echo "Please check your internet connection and try again."
fi

echo ""
echo "**************************************************"
echo "**                   FINISHED                   **"
echo "**************************************************"
sleep 2
exit "$INSTALL_RESULT"



