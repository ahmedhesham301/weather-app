FROM python:slim

WORKDIR /app

COPY app.py .
COPY static static
COPY templates templates
COPY requirements.txt .

RUN pip install -r requirements.txt

EXPOSE 5000:5000

CMD [ "python3","app.py",""--host=0.0.0.0""]

