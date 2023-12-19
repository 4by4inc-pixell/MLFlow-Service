FROM python:3.9.18-bullseye

RUN mkdir -p /mlflow

RUN pip install \
    pymysql \
    boto3

RUN pip install mlflow==2.7.1

EXPOSE 5000

## Environment variables made available through the Fargate task.
## Do not enter values
CMD mlflow server \
    --host 0.0.0.0 \
    --port 5000 \
    --default-artifact-root ${BUCKET} \
    --backend-store-uri mysql+pymysql://${USERNAME}:${PASSWORD}@${HOST}:${PORT}/${DATABASE} \
    --app-name basic-auth
