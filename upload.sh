#!/bin/bash
# script to upload website to github pages
jupyter book build .
cp SEO/** _build/html
ghp-import -n -p -f _build/html
echo "DO NOT FORGET TO PUSH THE MAIN BRANCH!"
