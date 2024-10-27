FROM madebytimo/builder AS builder

WORKDIR /root/builder

RUN apt update -qq && apt install -y -qq libhwloc-dev libssl-dev libuv1-dev \
    && rm -rf /var/lib/apt/lists/* \
    && download.sh --output xmrig.tar.gz \
        "https://github.com/xmrig/xmrig/archive/refs/heads/master.tar.gz" \
    && compress.sh --decompress xmrig.tar.gz \
    && rm xmrig.tar.gz \
    && mv xmrig-* xmrig-source \
    && sed --in-place 's|\(DonateLevel = \)1\(;\)|\10\2|' xmrig-source/src/donate.h \
    && mkdir build \
    && cmake -B build xmrig-source \
    && make --directory build --jobs $(nproc) \
    && mv build/xmrig . \
    && rm -r xmrig-source build

FROM madebytimo/base

RUN apt update -qq && apt install -y -qq libhwloc15 libssl3 libuv1 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /root/builder/xmrig /usr/local/bin/
COPY files/run.sh /usr/local/bin/

ENV DONATE_LEVEL="0"
ENV PROXY_URL=""
ENV SERVER_URL="stratum+tls://gulf.moneroocean.stream:20128"
ENV NICENESS_ADJUSTMENT="19"
ENV PASSWORD=""
ENV SCHED_POLICY="idle"
ENV WALLET_ADDRESS=\
"8BxBCFFvjozLXKVrn75xUijajMtyvMaNrHsRQEAARkpeYTacwG9NLwpAaM9Q6hfFaK4TSJKxfpL5AgJ9VNDmGjbB7BDmBa1"

CMD [ "run.sh" ]

HEALTHCHECK CMD [ "healthcheck.sh" ]

LABEL org.opencontainers.image.source="https://github.com/madebytimo/docker-xmrig"
