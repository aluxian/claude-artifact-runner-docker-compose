FROM node:22

# Install git
RUN apt-get update && apt-get install -y git

# Set working directory
WORKDIR /app

# Clone the repository
# Using HTTPS as it doesn't require SSH keys
RUN git clone https://github.com/claudio-silva/claude-artifact-runner.git .

# Install dependencies
RUN npm install

# Initial pre-cached build
RUN npx vite build

# Add artifact source files
RUN rm -rf /app/src/artifacts/*
COPY ./artifacts /app/src/artifacts

# Re-build
RUN npx vite build

# Expose default port (adjust if needed)
EXPOSE 4173

# Command to run the application
CMD ["npx", "vite", "preview", "--host"]
