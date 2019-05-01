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

#------------------------------------------------------------------------------
echo Cloning the Vundle bundle from github to the bundle directory...
#------------------------------------------------------------------------------

# Clone the Vundle bundle from gitbub to the bundle directory, delete if it
# already exists
[ -d "$bundle"/Vundle.vim ] && rm -Rf "$bundle"/Vundle.vim
git clone https://github.com/VundleVim/Vundle.vim.git "$bundle"/Vundle.vim \
2>/dev/null

# If cloning failed then simply download the snapshot of the bundle
if [ "$?" != "0" ];
then
    #--------------------------------------------------------------------------
    echo Cloning Failed. Downloading the Snapshot...
    #--------------------------------------------------------------------------
    wget -qO "$bundle"/master.zip https://github.com/VundleVim/Vundle.vim/\
archive/master.zip 2>/dev/null
    unzip "$bundle"/master.zip -d "$bundle" 2>/dev/null
    rm -f "$bundle"/master.zip
    mv "$bundle"/Vundle* "$bundle"/Vundle.vim/
    #--------------------------------------------------------------------------
    echo Downloaded the Snapshot of Vundle
    #--------------------------------------------------------------------------
else
    #--------------------------------------------------------------------------
    echo Cloning complete
    #--------------------------------------------------------------------------
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
vim +PluginInstall +qall
#------------------------------------------------------------------------------
echo Installation Complete
#------------------------------------------------------------------------------

