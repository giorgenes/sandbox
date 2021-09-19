FROM gitpod/workspace-base:latest

# hashicorp packer
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
RUN sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

RUN sudo apt-get update \
    && sudo apt-get install -y gnupg software-properties-common curl git dirmngr gpg gawk \
    build-essential procps file \
    packer \
    zsh \
    && sudo rm -rf /var/lib/apt/lists/*

# homebrew
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
RUN echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.bashrc.d/homebrew.sh
RUN bash -ic "brew update"

# hygen
RUN bash -ic "brew tap jondot/tap"
RUN bash -ic "brew install hygen"

RUN git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.8.1

RUN echo ". $HOME/.asdf/asdf.sh" >> $HOME/.bashrc.d/asdf.sh
RUN echo ". $HOME/.asdf/completions/asdf.bash" >> $HOME/.bashrc.d/asdf.sh

ENV BUMP_TO_FORCE_GITPOD_UPDATE=3
COPY .tool-versions $HOME/
COPY install-asdf-plugins.sh $HOME/
RUN ./install-asdf-plugins.sh
RUN bash -c ". $HOME/.bashrc.d/asdf.sh && asdf install"

#
RUN bash -ic "go get -v golang.org/x/tools/gopls"

# ZSH
ENV ZSH_THEME cloud
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended


# install ansible
#RUN bash -ic "python -m pip install --user ansible"
#RUN bash -ic "python -m pip install --user paramiko"

CMD [ "zsh" ]

