# syntax = docker/dockerfile:1

# Este Dockerfile está diseñado para producción, no para desarrollo.
# Usar con Kamal o build'n'run manualmente:
# docker build -t my-app .
# docker run -d -p 80:80 -p 443:443 --name my-app -e RAILS_MASTER_KEY=<valor de config/master.key> my-app

# Asegúrate de que RUBY_VERSION coincida con la versión de Ruby en .ruby-version
ARG RUBY_VERSION=3.2.2
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

# La app de Rails está aquí
WORKDIR /rails

# Instalar paquetes base
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libjemalloc2 libvips postgresql-client && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Establecer variables de entorno para producción
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development" \
    APPENTRETE_DATABASE_PASSWORD="Aldus1024@" 

# Fase de construcción para reducir el tamaño de la imagen final
FROM base AS build

# Instalar paquetes necesarios para construir gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libpq-dev pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Instalar gems de la aplicación
COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

# Copiar el código de la aplicación
COPY . .

# Precompilar los activos para producción sin requerir el RAILS_MASTER_KEY
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# Fase final de la imagen para la app
FROM base

# Copiar los artefactos construidos: gems y aplicación
COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /rails /rails

# Ejecutar y poseer solo los archivos en tiempo de ejecución como un usuario no root por seguridad
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp
USER 1000:1000

# El entrypoint prepara la base de datos
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Iniciar el servidor por defecto, esto se puede sobrescribir en tiempo de ejecución
EXPOSE 3000
CMD ["./bin/rails", "server"]
