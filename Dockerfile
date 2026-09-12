ARG REPOSITORY="docker.io"
FROM ${REPOSITORY}/library/debian:bookworm-20260824-slim
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
    && rm -rf /var/lib/apt/lists/*
# remove commands that could lead to a privilege escalation
RUN rm -f /bin/su /usr/bin/su /bin/mount /usr/bin/mount /bin/umount /usr/bin/umount \
    /usr/bin/passwd /usr/bin/chsh /usr/bin/chfn /usr/bin/chage /usr/bin/gpasswd \
    /usr/bin/newgrp /bin/login /usr/bin/login /usr/bin/nsenter /usr/bin/unshare \
    /usr/bin/setpriv /bin/setpriv
RUN find / -xdev \( -perm -4000 -o -perm -2000 \) -type f -exec chmod a-s {} + || true #remove all sguid flags and ignore possible errors
