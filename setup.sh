cd ~
ln -s .bash-config/bashrc .bashrc
ln -s .bash-config/bash_profile .bash_profile
ln -s .bash-config/gitconfig .gitconfig
ln -s .bash-config/dir_colors .dir_colors
ln -s .bash-config/tmux.conf .tmux.conf
UNAMESTR=`uname`
ln -s .bash-config/local/$UNAMESTR .profile_local
mkdir .config
cd .config
ln -s $HOME/.bash-config/omf/ omf
