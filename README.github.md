# GitHub Actions Deployment

This repository is configured with GitHub Actions for automated building and deployment.

## 🚀 Workflows

### 1. CI Pipeline (`.github/workflows/ci.yml`)
- **Triggers**: Push to `master`/`develop`, Pull Requests
- **Features**:
  - Tests on Ruby 3.3 and 3.4
  - Dependency installation and validation
  - Middleman build verification
  - Build output analysis

### 2. GitHub Pages Deployment (`.github/workflows/deploy.yml`)
- **Triggers**: Push to `master` branch
- **Features**:
  - Automatic build and deployment to GitHub Pages
  - Multi-stage build process
  - Proper base URL configuration for GitHub Pages
  - Artifact upload and deployment

### 3. Docker Image Building (`.github/workflows/docker.yml`)
- **Triggers**: Push to `master`, tags, Pull Requests
- **Features**:
  - Build and push to GitHub Container Registry
  - Multi-architecture support
  - Security vulnerability scanning with Trivy
  - Semantic versioning tags

### 4. Dependency Management (`.github/workflows/dependencies.yml`)
- **Triggers**: Weekly schedule, manual dispatch
- **Features**:
  - Outdated dependency detection
  - Security vulnerability scanning
  - Automated dependency updates via Pull Requests
  - Issue creation for security alerts

## 📋 Setup Instructions

### Enable GitHub Pages

1. Go to your repository **Settings**
2. Navigate to **Pages** section
3. Set **Source** to **GitHub Actions**
4. Save settings

### Repository Settings

Make sure your repository has these permissions enabled:

```yaml
permissions:
  contents: read
  pages: write
  id-token: write
```

### Secrets

The workflows use GitHub's built-in `GITHUB_TOKEN` - no additional secrets required for basic functionality.

## 🌐 Accessing Your Site

Once deployed:

- **GitHub Pages**: `https://[username].github.io/brandymint.ru-legacy/`
- **Preview builds**: Available in the Actions tab summary

## 🏷️ Versioning and Releases

### Tag-based Releases

```bash
# Create a new release
git tag v1.0.0
git push origin v1.0.0
```

This triggers:
- Docker image build with semantic tags
- GitHub Pages deployment
- Release creation

### Docker Images

Images are available at:
```bash
ghcr.io/[username]/brandymint.ru-legacy:latest
ghcr.io/[username]/brandymint.ru-legacy:v1.0.0
ghcr.io/[username]/brandymint.ru-legacy:main
```

## 🔧 Configuration

### Base URL Configuration

The GitHub Pages deployment automatically configures the base URL as `/brandymint.ru-legacy/`. This ensures all links and assets work correctly on GitHub Pages.

### Custom Domain

To use a custom domain:

1. Add a `CNAME` file to the `source/` directory
2. Configure your DNS settings
3. Update the GitHub Pages settings

### Environment Variables

Available environment variables in workflows:
- `GITHUB_TOKEN`: GitHub authentication token
- `GITHUB_REPOSITORY`: Repository name
- `GITHUB_REF`: Git reference (branch/tag)

## 📊 Monitoring

### Workflow Status

- **Actions Tab**: View all workflow runs and their status
- **Security Tab**: View vulnerability scan results
- **Insights Tab**: Repository analytics and traffic

### Dependency Updates

- **Dependabot**: Automatically creates PRs for dependency updates
- **Weekly Reports**: Issues created for outdated dependencies
- **Security Alerts**: Notifications for vulnerable dependencies

## 🐛 Troubleshooting

### Common Issues

**Build Failures:**
- Check workflow logs in the Actions tab
- Verify Ruby version compatibility
- Ensure all dependencies are properly installed

**Deployment Issues:**
- Confirm GitHub Pages is enabled in repository settings
- Check base URL configuration
- Verify repository permissions

**Permission Errors:**
- Ensure Actions permissions are enabled
- Check `GITHUB_TOKEN` permissions
- Verify repository collaborator access

### Debug Mode

To enable debug logging:

```yaml
env:
  MIDDLEMAN_ENV: development
  BUNDLE_DEPLOYMENT: "false"
```

## 🔄 Local Development

To test the build process locally:

```bash
# Install dependencies
make setup

# Build for GitHub Pages
export MIDDLEMAN_HTTP_PREFIX="/brandymint.ru-legacy"
make build

# Serve locally
make start PORT=4000
```

## 📝 Advanced Configuration

### Custom Workflows

You can extend the workflows by:

1. Adding custom build steps
2. Integrating with external services
3. Adding notification systems
4. Implementing custom deployment targets

### Caching Configuration

The workflows use GitHub's caching for:

- Ruby gems
- Node.js modules
- Docker layers

This significantly speeds up build times.

### Parallel Jobs

CI workflow runs jobs in parallel for different Ruby versions, providing faster feedback on compatibility issues.