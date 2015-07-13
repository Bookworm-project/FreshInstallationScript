#!/bin/bash

#
echo
echo "Set up the basics"
echo

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get install -y gcc
sudo apt-get install -y build-essential python-dev libmysqlclient-dev
sudo apt-get install -y parallel

#
echo
echo "Setting up a LAMP server on EC2"
echo

sudo apt-get install -y lamp-server^
sudo mysql_secure_installation



sudo apt-get install -y git

#
echo
echo "Install Python and Extensions"
echo

sudo apt-get install -y python-dev
sudo apt-get install -y python-pip
sudo pip install regex
sudo pip install nltk
sudo pip install numpy
sudo pip install mysql-python
sudo pip install python-dateutil




keeper="keeper"
keeperpass=""

reader="reader"
readerpass=""

mysql -u root -p --execute="CREATE USER '$keeper'@'localhost' IDENTIFIED BY '$keeperpass'; \
	GRANT ALL PRIVILEGES ON *.* TO '$keeper'@'localhost' WITH GRANT OPTION; \
	CREATE USER '$keeper'@'%' IDENTIFIED BY '$keeperpass'; \
	GRANT ALL PRIVILEGES ON *.* TO '$keeper'@'%' WITH GRANT OPTION; \
	CREATE USER 'admin'@'localhost'; \
	GRANT RELOAD,PROCESS ON *.* TO 'admin'@'localhost'; \
	CREATE USER '$reader'@'localhost' IDENTIFIED BY '$readerpass'; \
	GRANT SELECT ON *.* TO '$reader'@'localhost' WITH GRANT OPTION; \
	CREATE USER '$reader'@'%' IDENTIFIED BY '$readerpass'; \
	GRANT SELECT ON *.* TO '$reader'@'%' WITH GRANT OPTION;"

cd ~
echo " " >> .my.cnf
echo "#" >> .my.cnf
echo "# The MySQL Database Server Configuration File" >> .my.cnf
echo "#" >> .my.cnf
echo " " >> .my.cnf
echo "[client]" >> .my.cnf
echo "user = $keeper" >> .my.cnf
echo "password = $keeperpass" >> .my.cnf
echo " " >> .my.cnf


echo "This machine has been set up as a Bookworm server."
