# Use Ubuntu as base image
FROM ubuntu:20.04

# Avoid timezone prompt during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libboost-all-dev \
    libssl-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /app

# Copy source files
COPY . .

# Build the application
RUN make

# Expose DNS port (both TCP and UDP)
EXPOSE 53/tcp
EXPOSE 53/udp

# Default command to run the seeder
# Users should override these values with their own parameters
ENTRYPOINT ["./dnsseed", "-h", "dnsseed.example.com", "-n", "ns.example.com", "-m", "admin.example.com"]
