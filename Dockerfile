FROM python:3.10-slim

WORKDIR /usr/local/app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

CMD [ "flask", "--app", "flaskr", "run", "--debug", "--host=0.0.0.0"]

