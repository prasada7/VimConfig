# Vim configuration with Vundle
## Instructions for Installation
1. Clone this repository into the .vim directory<br>
<code>git clone https://github.com/prasada7/VimConfig.git</code>
2. Make sure the .vimrc file is not present in the ~ directory. If it is
present, rename the already present .vimrc to another file
3. Create a symbolic link to the installVundle.sh script from the ~/.vim
directory<br>
<code>ln -s ~/.vim/VimConfig/install.sh ~/.vim</code>
4. Execute the installVundle.sh script to complete the setup<br>
> *This file clones the Vundle repoitory from github into the ~/.vim/bundledir
ectory, creates a sym link to the .vimrc present in this repository from the
~ directory, and calls a vimscript function to install the Vundle Plugin*<br>
__Note__:  installVundle.sh will fail if .vimrc was not moved or deleted from the ~
directory. If that is the case, then: 
    1. Manually create a symbolic link to the .vimrc in this repository
    from the ~ directory
    2. Run vim and enter <code>:PluginInstall</code> to install Vundle

## Features included in this configuration
* Trailing whitespaces are always highlighted
* All whitespaces can be removed by pressing F2 or entering
<code>:Trailing</code>
* The Color Column is set at the 80th column
* Line numbers are enable by default (could be disables by entering
<code>:set nonu</code>
)
* The mouse could be used to set the cursor (This, however, conflicts with
certain mouse based functionality, such as pasting with right click)
> *Use* <code>:set mouse=</code> *To disable
* Automatic bracket closure for {}
* Ctrl+x (cut) and Ctrl+v could be used after highlighting with the mouse
> Assuming the mouse->cursor setting is enabled
* Ctrl+x is cut when in __visual__ mode and Ctrl+v is paste when in __insert__
mode
* Use F5 to save a file
* Use q in normal mode to close a window (force quit is not remapped)
* Use F4 to toggle the NERDTree Plugin
> For more information on NERDTree visit this
[link](https://github.com/scrooloose/nerdtree)


## Making use of the Vundle Plugin installer
* To search for a plugin, use <code>:PluginSearch</code>
* To install a plugin, simply add <code>Plugin '[Name]'</code> to the .vimrc
and call <code>:PluginInstall</code> in vim
> *TIP: Simply copy the line that resulted from the <code>:PluginSearch</code>*
into the .vimrc
* For more information please visit the [official github page](https://github.
com/VundleVim/Vundle.vim) for Vundle

