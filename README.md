# AWS Linux Monitoring & Auto-Recovery System

## Description
This project implements a Linux-based monitoring and auto-recovery system deployed on an AWS EC2 Ubuntu instance. It monitors an Nginx service, validates HTTP response, writes logs, and automatically restarts the service when a failure is detected.

## Technologies
- AWS EC2
- Ubuntu Server
- Nginx
- Bash
- systemd
- cron
- CloudWatch

## Features
- Service status validation
- HTTP response check
- Automatic service restart
- Log generation
- Cron-based automation
- CloudWatch monitoring

## Project Structure
````
aws-linux-monitoring-project/
├── monitor_nginx.sh
├── README.md
└── logs/
    └── monitor.log
````

## Screenshots

### EC2 instance running
![EC2 instance running](screenshots/01-ec2-instance-running.png)

### Security Group rules
![Security Group rules](screenshots/02-security-group-rules.png)

### SSH connection from Windows
![SSH connection](screenshots/03-ssh-connection.png)

### Nginx service active
![Nginx active](screenshots/04-nginx-active.png)

### Nginx running in browser
![Nginx browser](screenshots/05-nginx-browser.png)

### Monitoring script
![Monitoring script](screenshots/06-monitor-script.png)

### Monitoring logs
![Monitoring logs](screenshots/07-monitor-logs.png)

### Nginx stopped manually
![Nginx stopped](screenshots/08-nginx-stopped.png)

### Auto-recovery test
![Auto recovery](screenshots/09-auto-recovery.png)

### Cron automation
![Cron automation](screenshots/10-cron-automation.png)

### CloudWatch alarm
![CloudWatch alarm](screenshots/11-cloudwatch-alarm.png)
