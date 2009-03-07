# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def cloud_tag(word)
    style = "font-size: #{(word.size_factor * 100).round / 100.0}em; left: #{word.x}px; top: #{word.y}px"
    %[<li class='word' style="#{style}">#{word.text} (#{word.value})</li>\n]
  end

end
