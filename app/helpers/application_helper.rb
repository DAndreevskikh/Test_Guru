module ApplicationHelper
  FLASH_CLASSES = {
    notice: 'alert alert-primary',
    alert: 'alert alert-warning',
    error: 'alert alert-danger'
  }.freeze

  def current_year
    Time.current.year
  end

  def github_url(author, repo)
    link_to author, "https://github.com/#{author}/#{repo}", target: '_blank', rel: 'noopener noreferrer', class: 'text-decoration-none'
  end

  def flash_messages
    content_tag(:div, class: "flash-messages-container") do
      flash.map do |type, message|
        content_tag(:div, message.html_safe, class: "#{FLASH_CLASSES[type.to_sym] || 'alert'} alert-dismissible fade show", role: 'alert')
      end.join.html_safe
    end
  end

  def t_js(key, options = {})
    I18n.t(key, options).to_json
  end
end
