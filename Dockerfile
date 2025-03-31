# Use Python as base image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

#  work directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy files
COPY . .

# Run migrations
RUN python manage.py makemigrations
RUN python manage.py migrate

#Create Superuser 
RUN python manage.py createsuperuser

# Expose port for Django
EXPOSE 8000

# Command to run server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
