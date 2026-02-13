# 1. Use Debian Slim (includes glibc, avoids Alpine errors)
FROM node:22-bookworm-slim

# 2. Install only the essential build tools to save RAM
RUN apt-get update && apt-get install -y \
    python3 \
    make \
    g++ \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 3. Copy and install
COPY package*.json ./
RUN npm install --production

COPY . .

# 4. Render provides a dynamic PORT variable automatically
EXPOSE 10000

# 5. Start OpenClaw and tell it to use Render's dynamic port
CMD ["sh", "-c", "npx openclaw start --port ${PORT:-10000}"]
