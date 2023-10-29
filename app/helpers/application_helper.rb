# app/helpers/application_helper.rb
module ApplicationHelper
  def error(object, field)
    if object.errors[field].any?
      content_tag(:div, object.errors[field].join(', '), class: 'error-message')
    end
  end
end
