FROM alpine:latest

# Install necessary runtime dependencies
RUN apk add --no-cache curl jq ca-certificates bash wget

WORKDIR /app

# Download the latest Linux release of NullClaw
RUN LATEST_TAG=$(curl -s https://api.github.com/repos/nullclaw/nullclaw/releases/latest | jq -r .tag_name) && \
    echo "Downloading NullClaw version $LATEST_TAG..." && \
    wget "https://github.com/nullclaw/nullclaw/releases/download/${LATEST_TAG}/nullclaw-linux-x86_64.bin" -O /app/nullclaw && \
    chmod +x /app/nullclaw || \
    echo "Warning: Could not automatically fetch binary. You may need to build or download it manually."
# Ensure the default configuration directory exists
RUN mkdir -p /root/.nullclaw

# Copy the custom configuration
COPY config.json /root/.nullclaw/config.json

# If NullClaw runs a web server/dashboard, expose the appropriate port
EXPOSE 8080

# Run NullClaw
CMD ["/app/nullclaw"]
