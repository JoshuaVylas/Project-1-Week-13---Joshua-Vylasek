#!/bin/bash

sudo touch ~/backups/freemem/free_mem.txt && sudo free -m > ~/backups/freemem/free_mem.txt

sudo touch ~/backups/diskuse/disk_usage.txt && sudo du -h > ~/backups/diskuse/disk_usage.txt

sudo touch ~/backups/openlist/open_list.txt && sudo lsof /dev/null > ~/backups/openlist/open_list.txt

sudo touch ~backups/freedisk/free_disk.txt && sudo df -h / > ~/backups/freedisk/free_disk.txt
