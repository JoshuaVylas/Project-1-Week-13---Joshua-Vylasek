## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![image](https://user-images.githubusercontent.com/94200443/161395152-5375ed19-03b4-48b3-9789-f2c87b66b1e3.png)


These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the YML file may be used to install only certain pieces of it, such as Filebeat.

We will use Ansible yml files to automate this task
Here is a quick run down of the following:

The following: Will install ELK. ELK is a combination of programs that will help us monitor out systems and data.
  - Project-1-Week-13---Joshua-Vylasek/Ansible/Install-Elk.yml 

The following: Will install Filebeat on web servers so we can gather log data
  - Project-1-Week-13---Joshua-Vylasek/Ansible/Filebeat-Playbook.yml

The following: Will | Will install metricbeat on web servers so we can can keep an eye on our processes.
  - Project-1-Week-13---Joshua-Vylasek/Ansible/Metricbeat-Playbook.yml
  

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting access to the network.
- Load Balancers protect the availibity of the of the web servers, acting as a reverse proxy and distributes network or application traffic across a number of servers.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the event and system metrics.
- Filebeat is a lightweight shipper for forwarding and centralizing log data. Installed as an agent on your servers, Filebeat monitors the log files or locations that you specify, collects log events, and forwards them either to Elasticsearch or Logstash for indexing.
- Metricbeat takes the metrics and statistics that it collects and ships them to the output that you specify, such as Elasticsearch or Logstash.

The configuration details of each machine may be found below.

| Name     | Function | IP Address | Operating System        |
|----------|----------|------------|------------------       |
| Jump Box | Gateway  | 10.0.0.4   | Linux (Ubuntu 18.04 LTS)|
| Web-1    |Web Server| 10.0.0.5   | Linux (Ubuntu 18.04 LTS)|
| Web-2    |Web Server| 10.0.0.6   | Linux (Ubuntu 18.04 LTS)|
| Elk-VM   |Log server| 10.1.0.4   | Linux (Ubuntu 18.04 LTS)|

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jumpbox machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- My personal IP address.

Machines within the network can only be accessed by SSH.
- The Elk-Server machine is only open through ssh from the Jumpbox's ansible container and through web access from my Personal IP address
- The web machines are only accessable through ssh from my Jumpbox's ansible container and personal IP

A summary of the access policies in place can be found in the table below.

| Name      | Publicly Accessible            | Allowed IP Addresses                                  |
|-----------|--------------------------------|-------------------------------------------------------|
| Jump Box  |No                              |Personal IP address                                    |
| Web-1     |Yes, but only with Load Balancer|10.0.0.4 ssh from Jumpbox                              |
| Web-2     |Yes, but only with Load Balancer|10.0.0.4 ssh from Jumpbox                              |
| Elk-Server|No                              |10.0.0.4 ssh from jumpbox http port 5601 to personal IP|

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- We can deploy multiple servers simultaniously, automating installation without having to physically do anything.

The playbook implements the following tasks:
- Install Docker.io and pip3
- Increase VM memory
- Download and Configure elk docker containers

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![image](https://user-images.githubusercontent.com/94200443/161395215-7af1bc14-af8d-424d-9d71-ebd5a18da926.png)


### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Web-1 10.0.0.5
- Web-2 10.0.0.6

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat watches for log files and locations. It also collects Log events and puts them into a readable format. We can see the logs, path, and settings.
- Metricbeat records metrics and statistics from the operating system of the system it is running on. Helps to keep an eye on everything within the Elk Stack.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

ssh into the control node and follow the steps below:

- Copy the filebeat.config.yml, filebeat.yml, metricbeat.yml and metricbeat.config.yml file to /etc/anisble/.

- Check that the configuration file includes the Private IP of the ELK-VM in the Elasticsearch and Kibana IP and port number line matching the following:
output.elasticsearch:
hosts: "10.1.0.4:9200"
  username: "elastic"
  password: "changeme"
setup.kibana:
  host: "10.1.0.4:5601"

- In /etc/ansible/hosts edit The webservers and elk ip addresses with private IPs of our web machines and elk to match the following:

[webservers] 
10.0.0.5 ansible_python_interpreter=/usr/bin/python3
10.0.0.6 ansible_python_interpreter=/usr/bin/python3
[elk]
10.1.0.4 ansible_python_interpreter=/usr/bin/python3


Now we should be able to run the playbook using the two following commands:
ansible-playbook filebeat.yml
ansible-playbook metricbeat.yml

- Run the playbooks, and navigate to the ELK-VM-PublicIP:5601/app/kibana to check that the installation worked as expected.

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._
Step by step commands from work station:
1. ssh azadmin@JumpboxIP (to connect to Jumpbox)
2. sudo docker container list -a (to see container name)
3. sudo docker containter start container_name (to start the container)
4. sudo docker container attach container_name (to attach to the container)
5. cd /etc/ansible (to navigate to the anisble folder)
6. nano /etc/ansible/hosts and edit the following criteria: 
[webservers] 
10.0.0.5 ansible_python_interpreter=/usr/bin/python3
10.0.0.6 ansible_python_interpreter=/usr/bin/python3
[elk]
10.1.0.4 ansible_python_interpreter=/usr/bin/python3
7. ansible-playbook Install-Elk.yml (This installs and configures ELK on our ELK-VM)
8. Adjust both filebeat.config.yml and metricbeat.config.yml IP's to the following: 
output.elasticsearch:
hosts: "10.1.0.4:9200"
  username: "elastic"
  password: "changeme"
setup.kibana:
  host: "10.1.0.4:5601"
9. run both playbooks with the following commands:
anisble-playbook Metricbeat-Playbook.yml
anisble-playbook Filebeat-Playbook.yml
10. Open a browser on your personal workstation and navigate to ELK-server-publicIP:5601/app/kibana to view the new Kibana web portal. There you should be recieving logs and metric data from your web machines.
