#!/bin/bash

mkdir -p /var/backup
tar dvf /var/backup/home.tar /home
mv /var/backup/home.tar /var/backup/home.01012020.tar
tar cvf /var/backup/system.tar /home
ls -lh /var/backup > /var/backup/file_report.txt
free -h > /var/backup/disk_report.txt
