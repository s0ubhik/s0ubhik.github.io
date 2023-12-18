### System Info

Build
```
Linux ubuntu 6.2.0-39-generic #40~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Thu Nov 16 10:53:04 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
```
IP address
```
34.42.216.243
```
User
```
soubhik
```

Environment
```
/home/soubhik/env
```

### Application Info
Source: [utpalendubarman/FastGPT](https://github.com/utpalendubarman/FastGPT)

The application on the system is installed under `/home/soubhik/FastGPT`

If you are not logged in as `soubhik` running scripts might break the system, to switch to this account `su` can be used
```
sudo su soubhik
```

### Managing the Server

The modified version of FastGPT is installed in the system with the next.js production module on port 80. the server process is made to be systemd service name `myapp`

##### Start
```
sudo systemctl start myapp
```
##### Stop
```
sudo systemctl stop myapp
```
##### Restart
```
sudo systemctl restart myapp
```
To install it as a service run `scripts/install`

### Deploying Updates
The Application on production can be updated both manually and by webhook, if you intend to do it manually run
```
~/update
```
If you have broken some code in the FastGPT folder the update will also fail in that case use `-f` flag to forcefully update
```
~/update -f
```

#### Using Webhook
If the server is up and running one can hit `/api/admin/update`, this will internally run the update script as a separate process

```
http://34.42.216.243/api/admin/update
```

One may add it to GitHub webhook as every time the code it pushed the updates will be applied automatically

### Contact
configured by **Soubhik Biswas** (soubhik1809@gmail.com)

under the light of **Utpalendu Barman**



