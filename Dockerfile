FROM node:20-slim

# Install Tailscale and dependencies
RUN apt-get update && apt-get install -y curl tailscale openssh-client

WORKDIR /app
COPY . .
RUN npm install

# Create the start script
RUN echo '#!/bin/sh\n\
tailscaled --tun=userspace-networking & \n\
tailscale up --authkey=$TS_AUTHKEY --hostname=openclaw-render\n\
npx openclaw start' > /app/start.sh
RUN chmod +x /app/start.sh

CMD ["/app/start.sh"]
