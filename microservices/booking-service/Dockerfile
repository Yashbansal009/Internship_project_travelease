# Dockerfile for booking-service
FROM node:18-alpine
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install --production

# Copy application code
COPY . .

# Build step (if using TypeScript or a build tool)
RUN npm run build 

# Expose port (change if your app uses a different port)
EXPOSE 5000

# Start the service
CMD ["node", "index.js"] # REQUIRED: Change entrypoint if your main file is different



# Dockerfile for Booking Service
# Fill in with your base image, dependencies, and entrypoint
# Example:
# FROM python:3.10-slim
# COPY app/ /app
# WORKDIR /app
# RUN pip install -r requirements.txt
# CMD ["python", "main.py"]
