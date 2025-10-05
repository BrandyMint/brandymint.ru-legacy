# Docker Deployment for Brandymint Website

This directory contains Docker configuration for deploying the Brandymint static website.

## Quick Start

### Using Docker Compose (Recommended)

```bash
# Build and start the container
docker-compose up --build

# Access the website
open http://localhost:8080
```

### Using Docker directly

```bash
# Build the image
docker build -t brandymint-website .

# Run the container
docker run -p 8080:80 --name brandymint-website brandymint-website

# Access the website
open http://localhost:8080
```

## Development Workflow

### Development with Live Reload

For development with live reload, use the original Middleman setup:

```bash
make setup
make start
```

### Production Build

```bash
# Build for production
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up --build
```

## Configuration

### Environment Variables

- `NGINX_HOST`: Server hostname (default: localhost)
- `NGINX_PORT`: Server port (default: 80)

### Nginx Configuration

The `nginx.conf` file includes:
- Gzip compression for static assets
- Asset caching headers
- Security headers
- Directory index support (removes .html extensions)

### Multi-stage Build

The Dockerfile uses a multi-stage build:
1. **Builder stage**: Builds the Middleman site
2. **Final stage**: Serves static files with nginx

## Deployment

### Production Deployment

1. Build the image:
```bash
docker build -t brandymint-website:latest .
```

2. Tag and push to registry:
```bash
docker tag brandymint-website:latest your-registry/brandymint-website:latest
docker push your-registry/brandymint-website:latest
```

3. Deploy with docker-compose:
```bash
docker-compose -f docker-compose.prod.yml up -d
```

### Manual Static File Deployment

If you prefer to deploy static files manually:

```bash
# Build the Docker image to get the compiled site
docker build -t brandymint-website-builder .

# Extract the built files
docker run --rm -v $(pwd)/dist:/output brandymint-website-builder cp -r /usr/share/nginx/html/. /output/

# Upload the contents of dist/ to your hosting provider
```

## Container Details

- **Base Image**: nginx:alpine for production
- **Builder Image**: ruby:3.4.2-slim
- **Size**: ~50MB compressed
- **Port**: 80 (mapped to 8080 on host)
- **Restart Policy**: unless-stopped

## Troubleshooting

### Build Issues

```bash
# Clean build without cache
docker-compose build --no-cache

# Check build logs
docker-compose logs
```

### Permission Issues

If you encounter permission issues with generated files:

```bash
# Fix file ownership
sudo chown -R $USER:$USER build/
```

### Port Conflicts

If port 8080 is in use:

```bash
# Use a different port
docker run -p 9090:80 brandymint-website
```

## Security Considerations

- The container runs as non-root user (nginx)
- Static files are served with read-only permissions
- Security headers are configured in nginx
- No sensitive data is stored in the container