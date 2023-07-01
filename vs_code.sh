sudo apt autoremove -y snapd
sudo apt purge -y snapd
rm -rf ~/snap
sudo rm -rf /snap
sudo rm -rf /var/snap
sudo rm -rf /var/lib/snapd
clear
echo "VScode Installer @s0uhbik"
echo "Downloading VS-Code..."
curl -o vscode.deb https://az764295.vo.msecnd.net/stable/695af097c7bd098fbf017ce3ac85e09bbc5dda06/code_1.79.2-1686734195_amd64.deb --progress-bar
sudo dpkg -i vscode.deb
sudo rm vscode.deb
echo "Installed Successfully. run 'code' to start vscode"
