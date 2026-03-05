FROM python:3.14-slim

RUN useradd -m -s /bin/bash flaskruser  

WORKDIR /usr/local/app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN chown -R flaskruser:flaskruser /usr/local/app

USER flaskruser

RUN chmod +x entrypoint.sh

EXPOSE 5000

ENTRYPOINT ["/usr/local/app/entrypoint.sh"]

