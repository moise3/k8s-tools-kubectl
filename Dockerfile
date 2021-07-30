FROM alpine:3.14.0

ARG KUBECTL_VERSION=v1.21.3

LABEL Name=kubectl Version=${KUBECTL_VERSION}

ADD https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl /usr/local/bin/kubectl

ENV HOME=/config

RUN set -x && \
    apk add --no-cache ca-certificates && \
    chmod +x /usr/local/bin/kubectl && \
    adduser kubectl -Du 2342 -h /config && \
    kubectl version --client --short

USER kubectl

ENTRYPOINT ["/usr/local/bin/kubectl"]
