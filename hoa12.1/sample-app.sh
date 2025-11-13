#!/bin/bash

# Step 1: Create temporary directories
mkdir tempdir
mkdir tempdir/templates
mkdir tempdir/static

# Step 2: Copy files to temporary directory
cp sample_app.py tempdir/.
cp -r templates/* tempdir/templates/.
cp -r static/* tempdir/static/.

# Step 3: Create Dockerfile
echo "FROM python" >> tempdir/Dockerfile
echo "RUN pip install flask" >> tempdir/Dockerfile
echo "COPY ./static /home/myapp/static/" >> tempdir/Dockerfile
echo "COPY ./templates /home/myapp/templates/" >> tempdir/Dockerfile
echo "COPY sample_app.py /home/myapp/" >> tempdir/Dockerfile
echo "EXPOSE 8080" >> tempdir/Dockerfile
echo "CMD python3 /home/myapp/sample_app.py" >> tempdir/Dockerfile

# Step 4: Build the Docker container
cd tempdir
docker build -t sampleapp .

# Step 5: Start the container and verify
docker run -t -d -p 8080:8080 --name samplerunning sampleapp
docker ps -a
