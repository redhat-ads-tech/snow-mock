# Use the specified Red Hat Universal Base Image for Python 3.11
FROM registry.access.redhat.com/ubi9/python-311:latest

USER 0

# Set the working directory in the container
WORKDIR /opt/app-root/src

# Copy the requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY app.py .
COPY static/ static/

# Expose the port the app runs on
EXPOSE 8080

USER 1001

# Command to run the application using gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "app:app"]
