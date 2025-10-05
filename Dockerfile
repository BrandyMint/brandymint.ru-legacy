# Use Ruby 3.4.2 as base image
FROM ruby:3.4.2-slim

# Set environment variables
ENV RAILS_ENV=production
ENV RACK_ENV=production
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Install bower globally
RUN npm install -g bower

# Set working directory
WORKDIR /usr/src/app

# Copy Gemfile and Gemfile.lock
COPY Gemfile* ./

# Install Ruby dependencies
RUN bundle config set --local deployment 'true' && \
    bundle config set --local without 'development test' && \
    bundle install --jobs 4 --retry 3

# Copy the rest of the application
COPY . .

# Install frontend dependencies if bower.json exists
RUN if [ -f "bower.json" ]; then bower install --allow-root; fi

# Build the Middleman site
RUN bundle exec middleman build

# Use nginx to serve the static files
FROM nginx:alpine

# Copy built site to nginx
COPY --from=0 /usr/src/app/build /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]