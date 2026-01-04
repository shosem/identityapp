module ApplicationHelper
  def flash_bg_color(type)
    case type.to_sym
    when :success then "bg-green-500"
    when :danger then "bg-red-500"
    end
  end

  def page_title(title = "")
    base_title = '第五人格掲示板'
    title.present? ? "#{title} | #{base_title}" : base_title
  end
end
