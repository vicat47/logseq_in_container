FROM theasp/novnc


RUN set -ex; \
    sed -i 's|http://deb.debian.org/debian|https://mirrors.aliyun.com/debian|g' /etc/apt/sources.list; \
    sed -i 's|http://security.debian.org/debian-security|https://mirrors.aliyun.com/debian-security|g' /etc/apt/sources.list; \
    apt-get update; \
    apt-get install -y libglib2.0-0 libnss3 libatk1.0-0 libatk-bridge2.0-0 libcups2 libgtk-3-dev libpango1.0-dev libcairo2-dev libgbm-dev libxkbcommon-dev libasound2-dev \
    && apt-get install -y --fix-missing fontconfig fonts-wqy-microhei fonts-wqy-zenhei

RUN groupadd -g 1000 logseq
RUN useradd --create-home --no-log-init -u 1000 -g 1000 logseq

RUN apt-get install -y wget jq curl \
    && LATEST_RELEASE=$(curl -s https://api.github.com/repos/logseq/logseq/releases/latest | jq -r '.assets[] | select(.name | test("Logseq-linux-x64.*\\.AppImage$")) | .browser_download_url') \
    && wget -O logseq.AppImage "$LATEST_RELEASE" \
    && chmod +x logseq.AppImage \
    && ./logseq.AppImage --appimage-extract \
    && mv squashfs-root /opt/logseq \
    && rm logseq.AppImage \
    && apt-get remove -y wget jq curl \
    && apt-get autoremove -y

COPY run.sh /app/run.sh
RUN sed -i 's/\r$//' /app/run.sh && chmod +x /app/run.sh

#USER logseq
