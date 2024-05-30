#!/bin/bash
# script to upload website to github pages
jupyter book build .
ghp-import -n -p -f _build/html
