# How to install git, docker, maven
sudo apt install git
sudo apt install docker
sudo apt install docker-compose
sudo apt install maven

# How to deploy eFlower application
https://computingforgeeks.com/how-to-run-java-jar-application-with-systemd-on-linux/
- sudo groupadd -r appmgr
- sudo useradd -r -s /bin/false -g appmgr jvmapps
- id jvmapps
- sudo systemctl stop myapp.service
- sudo mvn clean package
- sudo rm /etc/systemd/system/myapp.service
- sudo vim /etc/systemd/system/myapp.service
```
[Unit]
Description=Manage Java service
    
[Service]
WorkingDirectory=/home/dr_quay_03/eflower-backend/target
ExecStart=java -Xms128m -Xmx256m -jar eflower-1.0.0.jar
User=jvmapps
Type=simple
Restart=on-failure
RestartSec=10
    
[Install]
WantedBy=multi-user.target
```
- sudo chown -R jvmapps:appmgr /home/dr_quay_03/eflower-backend/target
- sudo systemctl daemon-reload
- sudo systemctl start myapp.service
- systemctl status myapp