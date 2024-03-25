FROM postgres:14.5

ADD . /app

RUN apt update -y \
  && apt install -y tar \
  && apt install -y awscli \
  && apt install -y python3-pip

RUN pip install --upgrade pip \
  && pip install --upgrade awscli

WORKDIR /app

CMD ["bash","cnpg-backup.sh"]
