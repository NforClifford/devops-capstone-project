FROM python:3.9-slim

# Create working folder and install dependencies
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy your app code
COPY service/ ./service/

# Create a safe non-root user (security best practice)
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# Open port and start the app with gunicorn
EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]