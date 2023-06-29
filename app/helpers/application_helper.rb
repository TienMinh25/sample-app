module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = 'Ruby on Rails Tutorial Sample App'
    if page_title.empty?
      return base_title
    else
      return "#{page_title} | #{base_title}"
    end
  end
end
