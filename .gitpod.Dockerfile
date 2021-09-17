FROM gitpod/workspace-base:latest

RUN sudo apt-get update \
    && sudo apt-get install -y gnupg software-properties-common curl git dirmngr gpg gawk \
    build-essential procps file \
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
RUN bash -ic "python -m pip install --user ansible"
RUN bash -ic "python -m pip install --user paramiko"
