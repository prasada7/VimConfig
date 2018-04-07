#!/bin/bash

# Variable for the bundle directory
bundle=~/.vim/bundle

# Check if the bundle folder exists, create if it does not
if [ ! -d "$bundle" ];
then
        mkdir "$bundle"
fi

#------------------------------------------------------------------------------
echo Cloning the Vundle bundle from github to the bundle directory...
#------------------------------------------------------------------------------

# Clone the Vundle bundle from gitbub to the bundle directory
git clone https://github.com/VundleVim/Vundle.vim.git "$bundle"/Vundle.vim 2>/d\
ev/null

# If cloning failed then simply download the snapshot of the bundle
if [ "$?" != "0" ];
then
        #----------------------------------------------------------------------
        echo Cloning Filed. Downloading the Snapshot...
        #----------------------------------------------------------------------
        wget -qO "$bundle"/master.zip https://github.com/VundleVim/Vundle.vim/\
archive/master.zip 2>/dev/null
        unzip "$bundle"/master.zip -d "$bundle" 2>/dev/null
        rm -f "$bundle"/master.zip
        mv "$bundle"/Vundle* "$bundle"/Vundle.vim
        #----------------------------------------------------------------------
        echo Downloaded the Snapshot of Vundle
        #----------------------------------------------------------------------
else
        #----------------------------------------------------------------------
        echo Cloning complete
        #----------------------------------------------------------------------
fi

# Create a symbolic line to the vimrc from the home direcory
ln -s ~/.vim/.vimrc ~/.vimrc 2>/dev/null

# Check if the link succeeded, if not, simply ask the user to make a link manu
# -ally
if [ "$?" != "0" ];
then
        #----------------------------------------------------------------------
        echo Creating a symbolic link for the .vimrc failed since there alread\
                y exits one. Please copy the .vimrc to your home accordingly
        #----------------------------------------------------------------------
        exit 1
fi

# Install the vundle plugin
if ! vim -c "call InstallVundle()" ;
then
        #----------------------------------------------------------------------
        echo Installation failed.
        #----------------------------------------------------------------------
else
        #----------------------------------------------------------------------
        echo Installation successful
        #----------------------------------------------------------------------
fi
