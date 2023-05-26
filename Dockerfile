# Imagem base do Ruby
FROM ruby:3.1.2

# Definir variáveis de ambiente
ENV LANG C.UTF-8
ENV RAILS_ENV production

# Configurar diretório de trabalho
WORKDIR /app

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs \
  postgresql-client

# Instalar as gems do projeto
COPY Gemfile Gemfile.lock ./
RUN bundle install --without development test

# Copiar código do projeto
COPY . .

# Expor a porta do servidor
EXPOSE 3000

# Iniciar servidor
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
