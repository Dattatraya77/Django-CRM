# python image from docker hub
FROM python:3.12

# Set working directory
WORKDIR /app

# Copy requirements.txt file
COPY requirements.txt .

# pip upgrade
RUN pip install --upgrade pip

# Install libraries
RUN pip install --no-cache-dir -r requirements.txt

# copy the project file
COPY . .

# Expose the port to run project
EXPOSE 8181

# command to run django django project
CMD [ "python", "manage.py", "runserver", "0.0.0.0:8181" ]
