#!/bin/zsh

PWD=$(pwd)

cd $HOME
cd my-config/go

cd timer
go install 
cd ..

cd unicode
go install
cd ..

cd $PWD
