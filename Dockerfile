# Usando Ubuntu como base
FROM ubuntu:20.04

# Definir variáveis para que a instalação não peça interação do usuário
ENV DEBIAN_FRONTEND=noninteractive

# Atualizar pacotes e instalar dependências
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    cmake \
    libmariadb-dev \
    libmysqlclient-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Clonar o repositório do rAthena
WORKDIR /app
RUN git clone --depth 1 https://github.com/rathena/rathena.git .

# Compilar o rAthena
RUN mkdir build && cd build && cmake .. && make server

# Expor as portas do servidor Ragnarok
EXPOSE 5121 6121 6900

# Comando para iniciar o servidor automaticamente
CMD ["./build/run-server.sh"]
