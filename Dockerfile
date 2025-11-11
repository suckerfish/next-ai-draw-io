FROM node:20-slim

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

WORKDIR /app

# Copy package files and install ALL dependencies (including dev)
COPY package*.json ./
RUN npm ci

# Copy application code
COPY . .

# Build the application (creates .next directory)
RUN npm run build

# Create non-root user for security
RUN adduser --disabled-password --gecos '' --shell /bin/bash nextjs \
    && chown -R nextjs:nextjs /app

USER nextjs

# Set environment variables
ENV HOSTNAME=0.0.0.0
ENV NEXT_TELEMETRY_DISABLED=1

# Expose default port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
    CMD curl -f http://localhost:${PORT:-3000}/ || exit 1

# Default to production server (can override in docker-compose)
CMD ["npm", "start"]
