#!/bin/sh

DIR=`dirname ${0}`

# Remove old symbolic links
rm ${HOME}/.gvimrc
rm ${HOME}/.vimrc
rm ${HOME}/.vim

# Add new symbolic links
ln -s ${DIR}/vimrc    ${HOME}/.vimrc
ln -s ${DIR}/gvimrc   ${HOME}/.gvimrc
ln -s ${DIR}/vimfiles ${HOME}/.vim
