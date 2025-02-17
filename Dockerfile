# Usa a imagem base do Ubuntu
FROM ubuntu:20.04

# Evita perguntas interativas durante a instalação
ENV DEBIAN_FRONTEND=noninteractive

# Atualiza o sistema e instala dependências
RUN apt update && apt install -y \
    build-essential \
    git \
    libmysqlclient-dev \
    zlib1g-dev \
    libncurses5-dev \
    libreadline-dev \
    curl \
    cmake \
    make

# Define o diretório de trabalho
WORKDIR /rathena

# Copia os arquivos do repositório para dentro do container
COPY . /rathena

# Configura e compila o rAthena
RUN chmod +x configure && \
    ./configure && \
    make clean && \
    make server

# Exponha as portas do servidor
EXPOSE 5121 6121 6900

# Comando para iniciar o servidor
CMD ["./athena-start"]
