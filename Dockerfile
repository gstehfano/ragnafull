# Usando Ubuntu como base
FROM ubuntu:20.04

# Definir variáveis para evitar prompts interativos
ENV DEBIAN_FRONTEND=noninteractive

# Atualizar pacotes e instalar dependências essenciais
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    cmake \
    mariadb-client \
    mariadb-server \
    libmariadb-dev-compat \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Criar diretório de trabalho
WORKDIR /rathena

# Clonar o repositório do rAthena
RUN git clone --depth 1 https://github.com/rathena/rathena.git .

# Compilar o rAthena
RUN mkdir build && cd build && cmake .. && make server

# Copiar script de inicialização
COPY run-server.sh /rathena/
RUN chmod +x /rathena/run-server.sh

# Expor portas do servidor
EXPOSE 5121 6121 6900

# Comando para iniciar o servidor automaticamente
CMD ["/rathena/run-server.sh"]
