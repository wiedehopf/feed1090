# feed1090

## Installation:
```
sudo bash -c "$(wget -q -O - https://raw.githubusercontent.com/wiedehopf/feed1090/master/install.sh)"
```
or
```
wget -O /tmp/feed1090.sh https://raw.githubusercontent.com/wiedehopf/feed1090/master/install.sh
sudo bash /tmp/feed1090.sh
```

## Configuration:

Edit /etc/default/feed1090 to configure which IP addresses this script should get the ADS-B data from
```
sudo nano /etc/default/feed1090
```
Ctrl-x to exit, y (yes) to save when asked.
Then restart feed1090:
```
sudo systemctl restart feed1090
```

### Uninstallation:
```
sudo bash -c "$(wget -q -O - https://raw.githubusercontent.com/wiedehopf/feed1090/master/uninstall.sh)"
```
