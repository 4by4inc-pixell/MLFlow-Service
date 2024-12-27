FROM python:3.11

## Environment variables 
ENV AWS_ACCESS_KEY_ID="some_access_id"
ENV AWS_SECRET_ACCESS_KEY="some_access_key"
ENV S3_BUCKET="s3://bucket_name/path/"
ENV POSTGRES_MLFLOW_DATABASE="some_db_name"
ENV POSTGRES_HOST="some_db_url"
ENV POSTGRES_USERNAME="some_db_user"
ENV POSTGRES_PASSWORD="some_db_password"
ENV POSTGRES_PORT=3306

RUN mkdir -p /mlflow

RUN pip install \
    psycopg2-binary \
    boto3

RUN pip install mlflow==2.19.0

EXPOSE 5000

## Environment variables made available through the Fargate task.
## Do not enter values
CMD mlflow server \
    --host 0.0.0.0 \
    --port 5000 \
    --default-artifact-root ${S3_BUCKET} \
    --backend-store-uri postgresql+psycopg2://${POSTGRES_USERNAME}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_MLFLOW_DATABASE} 
