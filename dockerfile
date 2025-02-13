FROM python:slim

WORKDIR /app

COPY app.py .
COPY static static
COPY templates templates
COPY requirements.txt .

ENV OPENWEATHER_API_KEY=$OPENWEATHER_API_KEY

RUN pip install -r requirements.txt

EXPOSE 5000:5000

CMD [ "python3","app.py" ]

