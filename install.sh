#!/bin/bash

# Variable for the bundle directory
bundle=~/.vim/bundle

# Check if the bundle folder exists, create if it does not
if [ ! -d "$bundle" ];
then
    mkdir "$bundle"
fi

# Create a swaps directory if it already does not exist
if [ ! -d ~/.vim/.swaps/ ]
then
    mkdir ~/.vim/.swaps/
fi

# Create a symbolic link to the vimrc from the home direcory
ln -s ~/.vim/.vimrc ~/.vimrc 2>/dev/null

# Check if the link succeeded, if not, back it up using an incrementer
if [ $? -ne 0 ];
then
    # Find the the nth backup to rename the existing conf file to
    backcounter=0
    while [ -f ~/.vimrc.bak$(expr $backcounter + 1) ]
    do
        backcounter=$(expr $backcounter + 1)
    done
    backcounter=$(expr $backcounter + 1)

    # Create a backup of the already present vimrc and notify the user
    mv ~/.vimrc ~/.vimrc.bak$backcounter
    echo Backed up ~/.vimrc to ~/.vimrc.bak$backcounter

    ln -s ~/.vim/.vimrc ~/.vimrc
fi

# Install all the plugins specified in the conf
vim +PlugInstall
#------------------------------------------------------------------------------
echo Installation Complete
#------------------------------------------------------------------------------

