FROM postgres:17.5-bookworm

ADD . /app
RUN apt-get update \
    && apt-get install -y --no-install-recommends tar awscli \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /app
CMD ["bash","cnpg-backup.sh"]
