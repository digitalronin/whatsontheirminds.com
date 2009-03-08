# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def cloud_tag(word)
    style = "font-size: #{(word.size_factor * 100).round / 100.0}em;"
    style << " color: ##{word.colour};"
    style << " left: #{word.x}px;"
    style << " top: #{word.y}px"

    %[<li class='word' style="#{style}">#{word.text}</li>\n]
  end

end
