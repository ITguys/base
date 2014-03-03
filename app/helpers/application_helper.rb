module ApplicationHelper
  def error_messages_for(obj)
    if obj.errors.present?
      messages = ""
      obj.errors.messages.each do |k, v|
        messages << content_tag(:li, "#{t(k)} #{v.join(',')}")
      end
      content_tag :div, class: "alert alert-danger" do
        content_tag :ul do
          messages.html_safe
        end
      end
    end
  end
end
