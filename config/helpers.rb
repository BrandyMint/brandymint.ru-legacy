module ApplicationHelpers

  #########################
  # Metadata Helpers
  #########################
  def page_title
    title = "Company Name"
    if data.page.title
      title = data.page.title + " | " + title
    end
    title
  end

  def page_description
    if data.page.description
      description = data.page.description
    else
      description = "Set your site description in /helpers/site_helpers.rb"
    end
    description
  end

  #########################
  # Navigation Helpers
  #########################
  def navigation_class_for_path(path)
    request_path = "/#{request.path.gsub(/index\.html(.*?)$/, "")}"
    "active" if (path == request_path) || (path != "/" && request_path =~ /^(\/)?#{path}/i)
  end

  def navigation_item(label, path, optional_class = nil)
    content_tag(:li, link_to(label, path), :class => "#{navigation_class_for_path(path)} #{optional_class if optional_class}")
  end

  #########################
  # Utility Helpers
  #########################
  def slugify(string)
    string.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  # render Markdown. Strip wrapper <p> if wanted
  def md(key, options={})
    @markdown_renderer ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    html = @markdown_renderer.render(key)
    html = html.gsub(/^\s*<p\s*>|<\s*\/\s*p\s*>\s*$/i, '') if options[:no_p]
    html
  end

  def device_type(device)
    device ||= 'web'
    os = ''
    if device.downcase.match(/(iphone|ipad|ipod)/)
      os = 'ios'
    elsif device.downcase.match(/(s3|s4|galaxy|nexus|samsung)/)
      os = 'android'
    else
      os = 'web'
    end
    os
  end

  def device_type_url project, device
    device ||= 'web'
    type = device_type device
    case type
      when 'ios'
        url = project.appstore
      when 'android'
        url = project.google_play
      else
        url = project.url
    end
    url
  end

  def device_type_link project, device
    device ||= 'web'
    url = device_type_url(project, device)
    icon = content_tag :div, '', class: "project-block-platform #{device_type device}"
    if url.present?
      link_to icon, device_type_url(project, device), class: 'device-type-link', target: '_blank'
    else
      icon
    end
  end

  def app_badge platform, link
    link_to '&nbsp;', link, target: :blank, class: "app-badge app-badge-#{platform}"
  end

end
