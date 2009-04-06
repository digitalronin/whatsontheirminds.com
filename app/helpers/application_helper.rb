# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def cloud_tag(term)
    style = "font-size: #{(term.size_factor * 100).round / 100.0}em;"
    style << " color: ##{term.colour};"
    style << " left: #{term.x}px;"
    style << " top: #{term.y}px"

    %[<li class='term' style="#{style}">#{term.text}</li>\n]
  end

  def mp_clouds_list(mp)
    clouds = mp.clouds.collect do |cloud|
      text = cloud.created_at.to_date.to_s(:db)
      link_to text, cloud_path(cloud)
    end
    clouds.join "|"
  end

end
