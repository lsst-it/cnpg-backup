FROM postgres:15.8

ADD . /app

RUN apt update -y \
  && apt install -y tar \
  && apt install -y awscli \
  && apt install -y python3-pip

WORKDIR /app

CMD ["bash","cnpg-backup.sh"]
