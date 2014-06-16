#!/usr/bin/env python
#coding:utf-8

import os

CURRENT_PATH = os.getcwd()
HOME = os.environ['HOME']

LINK = [
    ("/vimrc",       "/.vimrc"),
    ("/gvimrc",      "/.gvimrc"),
    ("/vimfiles",    "/.vim"),
]

# Remove current exist links.
for (_, link) in LINK:
    try:
        os.remove(HOME + link)
    except OSError:
        pass

# Make links
for (src, link) in LINK:
    src = CURRENT_PATH + src
    link = HOME + link
    os.symlink(src, link)
