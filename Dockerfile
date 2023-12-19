FROM python:3.11

RUN mkdir -p /mlflow

RUN pip install \
    pymysql \
    boto3

RUN pip install mlflow==2.9.2

EXPOSE 5000

## Environment variables made available through the Fargate task.
## Do not enter values
CMD mlflow server \
    --host 0.0.0.0 \
    --port 5000 \
    --default-artifact-root ${S3_BUCKET} \
    --backend-store-uri mysql+pymysql://${MYSQL_USERNAME}:${MYSQL_PASSWORD}@${MYSQL_HOST}:${MYSQL_PORT}/${MYSQL_DATABASE} \
    --app-name basic-auth
