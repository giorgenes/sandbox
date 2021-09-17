FROM gitpod/workspace-base:latest

# hashicorp packer
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
RUN sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

RUN sudo apt-get update \
    && sudo apt-get install -y gnupg software-properties-common curl git dirmngr gpg gawk \
    build-essential procps file \
    packer \
    && sudo rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.8.1

RUN echo ". $HOME/.asdf/asdf.sh" >> $HOME/.bashrc.d/asdf.sh
RUN echo ". $HOME/.asdf/completions/asdf.bash" >> $HOME/.bashrc.d/asdf.sh

ENV BUMP_TO_FORCE_GITPOD_UPDATE=3
COPY .tool-versions $HOME/
COPY install-asdf-plugins.sh $HOME/
RUN ./install-asdf-plugins.sh
RUN bash -c ". $HOME/.bashrc.d/asdf.sh && asdf install"

# install ansible
#RUN bash -ic "python -m pip install --user ansible"
#RUN bash -ic "python -m pip install --user paramiko"
