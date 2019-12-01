# ---- Build Stage ----
FROM bitwalker/alpine-elixir-phoenix:latest AS app_builder

# Set environment variables for building the application
ENV MIX_ENV=prod \
    LANG=C.UTF-8 \
    SECRET_KEY_BASE=${SECRET_KEY_BASE} \
    ALEXA_SKILL_ID=${ALEXA_SKILL_ID} \
    APP_PORT=${APP_PORT} \
    APP_HOST=${APP_HOST} \
    SIGNING_SALT=${SIGNING_SALT}

RUN apk add --update git && \
    rm -rf /var/cache/apk/*

# Install hex and rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Create the application build directory
RUN mkdir /app
WORKDIR /app

# Copy over all the necessary application files and directories
COPY config ./config
COPY lib ./lib
COPY priv ./priv
COPY mix.exs .
COPY mix.lock .

# Fetch the application dependencies and build the application
RUN mix deps.get
RUN mix deps.compile
RUN mix phx.digest
RUN mix release

# ---- Application Stage ----
FROM bitwalker/alpine-elixir-phoenix:latest AS app

ENV LANG=C.UTF-8

# Install openssl
RUN apk add --update openssl ncurses-libs postgresql-client && \
    rm -rf /var/cache/apk/*

# Copy over the build artifact from the previous step and create a non root user
RUN adduser -D -h /home/app app
WORKDIR /home/app

COPY --from=app_builder /app/_build .

RUN chown -R app: ./prod
USER app

COPY entrypoint.sh .

# Run the Phoenix app
CMD ["./entrypoint.sh"]
