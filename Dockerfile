FROM python:3.14-slim

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

