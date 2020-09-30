FROM python:2.6-slim

# Copy local code to the container image.
ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . ./

# Install production dependencies.
# Copy application dependency manifests to the container image.
# Copying this separately prevents re-running pip install on every code change.

COPY requirements.txt .

RUN pip install -r requirements.txt

RUN python test.py

# Run the web service on container startup. Here we use the gunicorn
# webserver, with one worker process and 8 threads.
# For environments with multiple CPU cores, increase the number of workers
# to be equal to the cores available.

EXPOSE 8080

#CMD ["gunicorn", "--bind", "0.0.0.0:8080",  "--workers", "1", "--threads", "8", "app:app", "--timeout", "900"]
CMD exec gunicorn --bind :"0.0.0.0:8080", --workers 1 --threads 8 --timeout 0 app:app
