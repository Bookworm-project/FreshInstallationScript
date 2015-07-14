#!/bin/bash

#
echo
echo "Set up the basics"
echo

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get install -y gcc

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password'

sudo apt-get install -y mysql-server-5.5
sudo apt-get install -y build-essential python-dev libmysqlclient-dev
sudo apt-get install -y parallel

#
echo
echo "Setting up a LAMP server on EC2"
echo

sudo apt-get install -y lamp-server^
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


# At this point, mysql has no root password.

keeper="keeper"
keeperpass=""

reader="reader"
readerpass=""

# These commands are sufficient to create a user if it does not exist.
# http://stackoverflow.com/questions/13357760/mysql-create-user-if-not-exists

mysql -u root --execute="
	GRANT ALL PRIVILEGES ON *.* TO '$keeper'@'localhost' WITH GRANT OPTION; \
	GRANT RELOAD,PROCESS ON *.* TO 'admin'@'localhost'; \
	GRANT SELECT ON *.* TO '$reader'@'localhost'; \
"

# No longer changing to `~/`, because as root that isn't the user's home directory.
# So now these commands must be run from inside ~, which seems reasonable?

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
