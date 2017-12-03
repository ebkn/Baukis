module ApplicationHelper
  include HTMLBuilder

  def document_title
    if @title.present?
      "#{@title} - Baukis"
    else
      'Baukis'
    end
  end

  def flash_class_for(flash_type)
    case flash_type
    when 'alert'   then 'alert-danger'
    when 'notice'  then 'alert-success'
    end
  end
end
