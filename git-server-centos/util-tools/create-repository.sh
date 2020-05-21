#!/bin/bash

mkdir /home/git/$1.git
cd /home/git/$1.git
git init --bare
chown -R git:git /home/git/$1.git