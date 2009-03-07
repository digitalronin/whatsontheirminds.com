# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def cloud_tag(word)
    style = "font-size: #{word.value * 50}%; left: #{word.x}px; top: #{word.y}px"
    %[<li class='word' style="#{style}">#{word.text}</li>\n]
  end

end
