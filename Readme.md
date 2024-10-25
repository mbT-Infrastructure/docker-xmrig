# XMRig image

This image contains [XMRig].

## Installation

1. Pull from [Docker Hub], download the package from [Releases] or build using `builder/build.sh`

## Usage

This Container image extends the [base image].

Run the container in privileged mode to allow automatic MSR register configuration.

### Environment variables

-   `DONATE_LEVEL`
    -   Percentage of your hashing power that you want to donate to the developers of XMRig,
        default: `0`.
-   `PROXY_URL`
    -   Run network communication through specified proxy.
-   `SERVER_URL`
    -   Url of the mining server, default: `stratum+tls://gulf.moneroocean.stream:20128`.
-   `PASSWORD`
    -   Password for mining server.
-   `WALLET_ADDRESS`
    -   Username for mining server, defaults to donation wallet.

## Development

To run for development execute:

```bash
docker compose --file docker-compose-dev.yaml up --build
```

[base image]: https://github.com/mbT-Infrastructure/docker-base
[Docker Hub]: https://hub.docker.com/r/madebytimo/xmrig
[Releases]: https://github.com/mbT-Infrastructure/docker-xmrig/releases
[XMRig]: https://xmrig.com/
