FROM postgres:16.8-bullseye

ADD . /app
RUN apt-get update \
    && apt-get install -y --no-install-recommends tar python3-pip \
    && pip install --no-cache-dir awscli \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /app
CMD ["bash","cnpg-backup.sh"]

