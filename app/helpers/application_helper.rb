# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def cloud_tag(word)
    colour = (word.size_factor * 10).to_i.to_s(16).first * 3
    style = "font-size: #{(word.size_factor * 100).round / 100.0}em; color: ##{colour}; left: #{word.x}px; top: #{word.y}px"
    %[<li class='word' style="#{style}">#{word.text}</li>\n]
  end

end
