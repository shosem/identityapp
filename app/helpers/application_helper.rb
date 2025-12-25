module ApplicationHelper
  def flash_bg_color(type)
    case type.to_sym
    when :success then "bg-green-500"
    when :danger then "bg-red-500"
    end
  end
end
