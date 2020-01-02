FROM python:3.8.0-slim
RUN apt-get update \
    && apt-get clean

COPY . .

RUN pip install -r requirements.txt

EXPOSE 5000
CMD python app.py
