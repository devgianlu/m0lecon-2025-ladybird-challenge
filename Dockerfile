FROM cybersecnatlab/socaz:ubuntu-noble AS socaz

FROM ubuntu:24.04 AS readflag

RUN apt update && apt install -y gcc

WORKDIR /src
COPY readflag.c .
RUN gcc readflag.c -o readflag

FROM ubuntu:24.04

RUN apt update && apt install -y python3

USER root

COPY wrapper.py /srv/wrapper
RUN chmod 755 /srv/wrapper

COPY flag /srv/flag
RUN chmod 400 /srv/flag

COPY --from=readflag /src/readflag /srv/readflag
RUN chmod +sx /srv/readflag

COPY --from=socaz /usr/local/bin/socaz /usr/bin/socaz
RUN chmod +x /usr/bin/socaz

COPY ./build /srv/ladybird
RUN chmod 755 /srv/ladybird/bin/js

RUN useradd ladybird
USER ladybird

ENTRYPOINT ["socaz", "--timeout", "30", "--bind", "1337", "--stderr", "--cmd", "stdbuf -i0 -o0 -e0 /srv/wrapper"]
