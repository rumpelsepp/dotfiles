#!/bin/bash

curl -Ls "$1" | grep -iPo '(?<=<title>)(.*)(?=</title>)'
