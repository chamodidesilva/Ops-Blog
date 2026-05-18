# FROM python:3.14-slim
FROM python:3.14.5-slim-trixie

# update specific debian 13 packages due to vulnerabilities not yet fixed in the base image
# RUN apt-get update && apt-get install -y --no-install-recommends \
#     libcap2 \
#     libsystemd0 \
#     libudev1 \
#     && rm -rf /var/lib/apt/lists/*

RUN groupadd -g 1000 flaskrgroup && \
    useradd -u 1000 -g flaskrgroup -m -s /bin/bash flaskruser

WORKDIR /usr/local/app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN chown -R 1000:1000 /usr/local/app

USER 1000

RUN chmod +x entrypoint.sh

EXPOSE 5000

ENTRYPOINT ["/usr/local/app/entrypoint.sh"]

