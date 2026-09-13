ARG REPOSITORY="docker.io"
FROM ${REPOSITORY}/library/debian:forky-20260824-slim
# install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    wget \
    ca-certificates \
    procps \
    build-essential \
    python3 \
    python3-dev \
    nodejs \
    npm \
    fd-find \
    ripgrep \
    && rm -rf /var/lib/apt/lists/*
# remove commands that could lead to a privilege escalation
RUN rm -f /bin/su /usr/bin/su /bin/mount /usr/bin/mount /bin/umount /usr/bin/umount \
    /usr/bin/passwd /usr/bin/chsh /usr/bin/chfn /usr/bin/chage /usr/bin/gpasswd \
    /usr/bin/newgrp /bin/login /usr/bin/login /usr/bin/nsenter /usr/bin/unshare \
    /usr/bin/setpriv /bin/setpriv
RUN find / -xdev \( -perm -4000 -o -perm -2000 \) -type f -exec chmod a-s {} + || true #remove all sguid flags and ignore possible errors

RUN groupadd -g 1001 worker && \
    useradd --no-log-init -u 1001 -g worker -m -s /usr/sbin/nologin worker
# install pi
RUN npm install -g @earendil-works/pi-coding-agent
# create worker folders
RUN mkdir -p /home/worker/.pi/agent \
    /workspace \
    /home/worker/.config \
    /home/worker/.npm  \
    && chown -R worker:worker /home/worker/.pi \
    /workspace \
    /home/worker/.config \
    /home/worker/.npm

RUN ls -al /
# remove possible leaking vars from git commands
RUN printf '#!/bin/sh\n\
    unset GIT_TRACE\n\
    unset GIT_TRACE_CURL\n\
    unset GIT_TRACE_PACKET\n\
    unset GIT_TRACE_SETUP\n\
    unset GIT_TRACE_PERFORMANCE\n\
    unset GIT_CURL_VERBOSE\n\
    unset GIT_REFLOG_ACTION\n\
    exec /usr/bin/git "$@"\n' > /usr/local/bin/git \
    && chmod +x /usr/local/bin/git

WORKDIR /workspace
USER worker

# install popular litellm proxy
RUN pi install npm:pi-provider-litellm
RUN pi install npm:pi-plan

ENTRYPOINT ["pi"]
CMD []
