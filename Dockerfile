# 1. Use the Slim version of Debian (saves ~200MB of image space)
FROM node:22-bookworm-slim

# 2. Install essential build tools (required for node-llama-cpp)
RUN apt-get update && apt-get install -y \
    python3 \
    make \
    g++ \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 3. Copy dependencies first
COPY package*.json ./

# 4. Install only production dependencies to save RAM
RUN npm install --production

# 5. Copy the rest of your app files
COPY . .

# 6. Render needs port 10000 by default
EXPOSE 10000

# 7. CRITICAL: Max-old-space-size limits RAM usage to 350MB
# This prevents the "Heap out of memory" crash you just saw
CMD ["sh", "-c", "node --max-old-space-size=350 npx openclaw start --port ${PORT:-10000}"]
