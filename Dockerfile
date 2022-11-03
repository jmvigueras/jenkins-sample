FROM python:3
WORKDIR /usr/src/app
COPY index.html index.html
COPY server.py server.py
CMD ["python3","server.py"]