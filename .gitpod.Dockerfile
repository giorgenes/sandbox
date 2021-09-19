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
# ENV TRIGGER_BREW_REBUILD=2
# RUN mkdir ~/.cache && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# ENV PATH=$PATH:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin/
# ENV MANPATH="$MANPATH:/home/linuxbrew/.linuxbrew/share/man"
# ENV INFOPATH="$INFOPATH:/home/linuxbrew/.linuxbrew/share/info"
# ENV HOMEBREW_NO_AUTO_UPDATE=1
# RUN sudo apt remove -y cmake \
#     && brew install cmake
# RUN echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.bashrc.d/homebrew.sh

# hygen
# RUN bash -ic "brew tap jondot/tap"
# RUN bash -ic "brew install hygen"

RUN git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.8.1

RUN echo ". $HOME/.asdf/asdf.sh" >> $HOME/.bashrc.d/asdf.sh
RUN echo ". $HOME/.asdf/completions/asdf.bash" >> $HOME/.bashrc.d/asdf.sh

ENV BUMP_TO_FORCE_GITPOD_UPDATE=3
COPY .tool-versions $HOME/
COPY install-asdf-plugins.sh $HOME/
RUN ./install-asdf-plugins.sh
RUN bash -c ". $HOME/.bashrc.d/asdf.sh && asdf install"

# vscode go extension dependencies
RUN bash -ic "go get -v golang.org/x/tools/gopls"
RUN bash -ic "go get github.com/uudashr/gopkgs/v2/cmd/gopkgs"
RUN bash -ic "go get github.com/ramya-rao-a/go-outline"
RUN bash -ic "go get github.com/go-delve/delve/cmd/dlv"
RUN bash -ic "go get honnef.co/go/tools/cmd/staticcheck"

# hygen
RUN bash -ic "npm i -g hygen"

# ZSH
ENV ZSH_THEME cloud
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended


# install ansible
#RUN bash -ic "python -m pip install --user ansible"
#RUN bash -ic "python -m pip install --user paramiko"

CMD [ "zsh" ]

