# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a legacy static website for Brandymint, built with Middleman (Ruby static site generator). The site showcases the company's portfolio, services, team, and open-source projects. It supports both English and Russian languages.

## Development Commands

### Environment Setup
```bash
make setup          # Install dependencies (bundle and bower)
```

### Development Server
```bash
make start          # Start development server on 0.0.0.0:4567
bundle exec middleman  # Alternative way to start dev server
```

### Build
```bash
make build          # Build static site in `build` folder
bundle exec middleman build --verbose  # Verbose build
```

### Individual Tasks
```bash
make bundle         # Install Ruby gems
make bower          # Install frontend dependencies
```

**Note:** Capistrano deployment has been removed. Use `make build` and deploy the `build/` folder manually to your hosting provider, or use Docker for containerized deployment.

## Architecture & Key Patterns

### Technology Stack
- **Middleman 3.2.2** - Ruby static site generator
- **HAML** - Template engine for views
- **Sass/Compass** - CSS preprocessing with Bootstrap 3.0.3.0
- **Redcarpet** - Markdown processing
- **Bower** - Frontend package management
- **Manual deployment** - Build static files and upload to hosting

### Project Structure

#### Data Management (`data/`)
- YAML files organized by locale (`en/` and `ru/`)
- Content types: projects, products, services, team, events, navigation
- Data accessed in templates via `data.yml_file.key` (e.g., `data.projects.first.title`)

#### Models (`models/`)
- Ruby classes that wrap YAML data (Project, Speaker, Event, City)
- Each model has a `build(yaml)` class method and `all` class method
- Models are auto-loaded in `config.rb:3`

#### Views (`source/`)
- **Layouts**: `application.haml` (main), `page.haml`, partials for components
- **Templates**: HAML files using data models and helpers
- **Assets**: Stylesheets, JavaScripts, images organized by type

#### Configuration (`config/`)
- **`config.rb`**: Main Middleman configuration
- **`helpers.rb`**: Custom template helpers
- **`routes.rb`**: Custom routing logic
- **`icon_helper.rb`**: Icon rendering utilities

### Key Architectural Patterns

#### Data-Driven Content
The site is highly data-driven with YAML content files processed through Ruby model classes. This separation allows for easy content updates without code changes.

#### Internationalization
- Two language support (English/Russian) with `activate :i18n`
- Separate data folders for each locale
- Language-specific navigation and content

#### Static Asset Pipeline
- Sprockets integration for asset compilation
- Bootstrap integration via Bower
- Asset optimization in production (minification, cache busting)

#### Helper System
Custom helpers in `config/helpers.rb` provide reusable functionality for templates, including route helpers and application-specific utilities.

## Docker Deployment

The project includes Docker configuration for containerized deployment:

```bash
# Quick start with Docker Compose
docker-compose up --build

# Access at http://localhost:8080
```

### Docker Components
- `Dockerfile` - Multi-stage build (Ruby builder + nginx serving)
- `nginx.conf` - Optimized nginx configuration with gzip and caching
- `docker-compose.yml` - Development deployment setup
- `.dockerignore` - Excludes unnecessary files from build context

## GitHub Actions Deployment

The project includes comprehensive GitHub Actions workflows for CI/CD:

### Automated Workflows
- **CI Pipeline** - Tests on Ruby 3.3/3.4, validates builds
- **GitHub Pages Deployment** - Automatic deployment on push to master
- **Docker Image Building** - Build/push to GitHub Container Registry
- **Dependency Management** - Automated updates and security scanning

### Quick Setup
1. Enable GitHub Pages in repository Settings → Pages
2. Set source to "GitHub Actions"
3. Push to master branch to trigger deployment

Site will be available at: `https://[username].github.io/brandymint.ru-legacy/`

### Docker Registry
Images available at: `ghcr.io/[username]/brandymint.ru-legacy:latest`

## Important Notes

- This is a legacy codebase using Middleman 4.x (upgraded from 3.x)
- Deployment has been modernized to use Docker containers
- Image optimization is available but commented out in config
- Google Analytics tracking should be added manually to layouts
- The build process excludes development files from production output
- Capistrano deployment has been removed in favor of Docker/static file deployment