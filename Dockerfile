FROM python:3.11

## Environment variables 
ENV AWS_ACCESS_KEY_ID="some_access_id"
ENV AWS_SECRET_ACCESS_KEY="some_access_key"
ENV S3_BUCKET="s3://bucket_name/path/"
ENV MYSQL_DATABASE="some_db_name"
ENV MYSQL_HOST="some_db_url"
ENV MYSQL_USERNAME="some_db_user"
ENV MYSQL_PASSWORD="some_db_password"
ENV MYSQL_PORT=3306

RUN mkdir -p /mlflow

RUN pip install \
    pymysql \
    boto3

RUN pip install mlflow==2.14.1

EXPOSE 5000

## Environment variables made available through the Fargate task.
## Do not enter values
CMD mlflow server \
    --host 0.0.0.0 \
    --port 5000 \
    --default-artifact-root ${S3_BUCKET} \
    --backend-store-uri mysql+pymysql://${MYSQL_USERNAME}:${MYSQL_PASSWORD}@${MYSQL_HOST}:${MYSQL_PORT}/${MYSQL_DATABASE} 
