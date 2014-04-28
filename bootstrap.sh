#!/usr/bin/env bash

apt-get update

echo "###############################################################"
echo "Installing essentials"
echo "###############################################################"
apt-get -y install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev


#Clone Git repo containing config files
echo "###############################################################"
echo "Cloning Huginn"
echo "###############################################################"
git clone https://github.com/cantino/huginn.git
cd huginn
git pull

#Install Huggin 

#Install Ruby (see: https://gist.github.com/mjhea0/b6b58eefc38985380ff9)
echo "###############################################################"
echo "Installing Ruby"
echo "###############################################################"
apt-get -y install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
curl -sSL https://get.rvm.io | bash -s stable
source /etc/profile.d/rvm.sh
echo "source /etc/profile.d/rvm.sh" >> ~/.bashrc
# 2.1.1 doesn't work
rvm install 2.0.0
rvm use 2.0.0 --default
ruby -v

#install mysql
echo "###############################################################"
echo "Installing MySQL"
echo "###############################################################"
#suppress mysql asking password (leave the password as blank)
export DEBIAN_FRONTEND=noninteractive
apt-get -y install mysql-server mysql-client libmysqlclient-dev

#Install rake and bundle
echo "###############################################################"
echo "Installing rake and bundle"
echo "###############################################################"
gem install rake bundle

# install dependencies
echo "###############################################################"
echo "Installing dependencies"
echo "###############################################################"
bundle install

#Generate secrets
echo "###############################################################"
echo "Generate secrets"
echo "###############################################################"
cp .env.example .env
SECRET=$(rake secret)
sed -i "s/REPLACE_ME_NOW\!/$SECRET/g" .env
# pull request #292
sed -i "s/dd//g" .env


#create database
echo "###############################################################"
echo "Create database"
echo "###############################################################"
rake db:create
rake db:migrate
rake db:seed

# run huggin
echo "###############################################################"
echo "Run Huggin"
echo "###############################################################"
foreman start

# # access Huggin via http://localhost:3000/ and login with the username
# # and the password of "admin" and "password", respectively.
