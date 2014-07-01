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

for (src, link) in LINK:
    src = CURRENT_PATH + src
    link = HOME + link

    # Remove current exist links.
    try:
        os.remove(link)
    except OSError:
        pass

    # Make links
    os.symlink(src, link)
