FROM python:3.11-alpine

# Bash needed for nextflow
RUN apk add --no-cache bash

RUN pip install --no-cache-dir nfixplanet==0.1.6