##############################
# Load data
Dir[File.join(File.dirname(__FILE__), 'models', '*.rb')].each{ |file| require file }

##############################
# Helpers
require 'config/routes'
require 'config/helpers'
require 'config/icon_helper'
require 'builder'

helpers do
  include RouteHelpers
  include ApplicationHelpers
  include IconHelper
end

##############################
# Markdown configuration
set :markdown_engine, :kramdown
set :markdown, :fenced_code_blocks => true,
               :autolink => true,
               :smartypants => true

# I18n configuration
activate :i18n, langs: [:en, :ru], mount_at_root: :ru, path: "/:locale/"

# Live reload in development
# activate :livereload

# Syntax highlighting for code blocks
activate :syntax, :line_numbers => true

# Google Analytics (manually add to layout in production)

# Deploy configuration
# activate :deploy do |deploy|
#   deploy.deploy_method = :git
#   deploy.build_before = true
# end

# Image optimization (disabled due to compatibility issues)
# activate :imageoptim do |options|
#   options.pngout = false
#   options.svgo = false
# end

# Layout configuration
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false
page "*", layout: "application"

# Directory indexes (removes .html from URLs)
activate :directory_indexes

# Asset pipeline
set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :relative_links, true

# Sprockets configuration (built-in to Middleman 4)
# activate :sprockets do |s|
#   s.supported_output_extensions << '.html'
# end

# after_configuration do
#   if File.exist?("#{root}/.bowerrc")
#     @bower_config = JSON.parse(IO.read("#{root}/.bowerrc"))
#     @bower_assets_path = File.join "#{root}", @bower_config["directory"]
#     sprockets.append_path @bower_assets_path
#   end

#   sprockets.append_path 'source/vendor'
#   sprockets.append_path 'vendor/javascripts'
#   sprockets.append_path 'vendor/stylesheets'
#   sprockets.append_path 'source/stylesheets/fonts'
# end

# Development configuration
configure :development do
  # Better errors for development
  if defined?(BetterErrors)
    use BetterErrors::Middleware
    BetterErrors.application_root = __dir__
  end

  # Disable minification in development
  set :debug_assets, true
end

# GitHub Pages configuration
configure :build do
  # Override relative assets for GitHub Pages
  set :relative_links, true

  # Set the base URL for GitHub Pages (will be overridden by environment)
  # This is a placeholder - the actual URL will be set in the workflow
  config[:http_prefix] = "/"
end

# Build configuration
configure :build do
  # Ignore development files
  ignore "/javascripts/application/*"
  ignore "/javascripts/vendor/lib/*"
  ignore "/stylesheets/vendor/*"
  ignore "/stylesheets/app/*"
  ignore "/vendor/components/*"
  ignore "*.rb"

  # Minify CSS
  activate :minify_css

  # Minify JavaScript
  activate :minify_javascript

  # Minify HTML
  activate :minify_html

  # Gzip files
  activate :gzip

  # Cache buster
  activate :asset_hash

  # Relative assets
  activate :relative_assets
end


