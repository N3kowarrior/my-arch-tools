#!/bin/bash

echo "Removing libraries which cause issues, please type your password to allow deletion"
sudo rm /opt/resolve/libs/libgmodule-2.0.so*
sudo rm /opt/resolve/libs/libglib-2.0.so*
sudo rm /opt/resolve/libs/libgio-2.0.so*

echo "Creating shell script"
touch davinci_wayland.sh
echo "#!/bin/bash
QT_QPA_PLATFORM=xcb /opt/resolve/bin/resolve" > davinci_wayland.sh

sudo chmod +x davinci_wayland.sh
echo "Done! Now moving"
mv davinci_wayland.sh /opt/resolve/bin/davinci_wayland.sh

echo "Editing desktop file/icon"
file="/home/$(whoami)/.local/share/applications/com.blackmagicdesign.resolve.desktop"
new_exec_line="Exec=/opt/resolve/bin/davinci_wayland.sh"
old_exec_line="Exec=/opt/resolve/bin/resolve"

# Check if the desktop file exists
if [ ! -f "$file" ]; then
    echo "$file does not exist. Exiting."
    exit 1
fi

# Use sed to replace the line in the desktop file
sed -i "s|$old_exec_line|$new_exec_line|g" "$file"

echo "Desktop file/icon updated successfully"
exit
