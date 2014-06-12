#!/usr/bin/env python
#coding:utf-8

import os

CURRENT_PATH = os.getcwd()
HOME = os.environ['HOME']

SRC = {
        "vimrc": CURRENT_PATH + "/vimrc",
        "gvimrc": CURRENT_PATH + "/gvimrc",
        "vimfiles": CURRENT_PATH + "/vimfiles",
}

LINK = {
        "vimrc": HOME + "/.vimrc",
        "gvimrc": HOME + "/.gvimrc",
        "vimfiles": HOME + "/.vim",
}


# Remove current exist links.
for key in LINK:
    os.remove(LINK[key])

# Make links
for key in LINK:
    os.symlink(SRC[key], LINK[key])
