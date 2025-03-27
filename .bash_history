 sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean
 sudo passwd -d dev

 sudo apt install git zip gawk make gcc docker.io docker-buildx libvips-dev -y
 sudo usermod -aG docker $USER

 sudo snap install go --classic 

 curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
 \. "$HOME/.nvm/nvm.sh"
 nvm install 22

 curl -fsSL https://pyenv.run | bash
 eval "$(pyenv virtualenv-init -)"
 pyenv install -l
 pyenv install 2.7.18
 pyenv install 3.13.2
 pyenv global 2.7.18

 unzip ssh.zip 
 mv id_rsa id_rsa.pub ~/.ssh/

 mkdir -p ~/PROJECTS

 sudo chown root:root ~/.bash_history
 sudo chmod 644 ~/.bash_history

 cat <<EOFDOCKERDAEMON | sudo tee /etc/docker/daemon.json
{
  "features": {
    "containerd-snapshotter": true
  }
}
EOFDOCKERDAEMON
 sudo systemctl restart docker
 docker buildx create --name container-builder --driver docker-container --bootstrap --use

 sh install-bash-autosuggestions.sh
 cat <<EOFBASHRC | tee -a ~/.bashrc
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export NVM_DIR="\$HOME/.nvm"
[ -s "\$NVM_DIR/nvm.sh" ] && \. "\$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "\$NVM_DIR/bash_completion" ] && \. "\$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PYENV_ROOT="\$HOME/.pyenv"
[[ -d \$PYENV_ROOT/bin ]] && export PATH="\$PYENV_ROOT/bin:\$PATH"
eval "\$(pyenv init - bash)"
EOFBASHRC
