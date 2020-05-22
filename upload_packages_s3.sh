#!/usr/bin/bash

source /etc/profile
source ~/.bashrc

aws configure set default.region $AWS_REGION

GPG_SECRET_JSON=`aws secretsmanager get-secret-value --secret-id $GPG_SECRET_ARN`

export GPG_PASSPHRASE=`echo $GPG_SECRET_JSON | jq --raw-output ".SecretString" | jq -r ".GPG_PASSPHRASE" | base64 -d`
export GPG_PRIVATE_KEY=`echo $GPG_SECRET_JSON | jq --raw-output ".SecretString" | jq -r ".GPG_PRIVATE_KEY" | base64 -d`
export GPG_PUBLIC_KEY=`echo $GPG_SECRET_JSON | jq --raw-output ".SecretString" | jq -r ".GPG_PUBLIC_KEY" | base64 -d`
export GPG_KEY_ID=`echo $GPG_SECRET_JSON | jq --raw-output ".SecretString" | jq -r ".GPG_KEY_ID" | base64 -d`



echo -e "$GPG_PUBLIC_KEY" | gpg1 --import
echo -e "$GPG_PRIVATE_KEY" | gpg1 --import

export BUILDDIR=`pwd`
mkdir .aptly

cat aptly.conf.template | envsubst > ~/.aptly.conf

aptly repo create -distribution=focal -component=freeswitch release
aptly repo add release .packages/*.deb
aptly publish --force-overwrite -passphrase=$GPG_PASSPHRASE repo release  s3:$APTLY_REPO_NAME:




