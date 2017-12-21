class FormPresenter
  include HTMLBuilder

  attr_reader :form_builder, :view_context
  delegate :label,
           :text_field,
           :password_field,
           :check_box,
           :radio_button,
           :text_area,
           :object,
           to: :form_builder

  def initialize(form_builder, view_context)
    @form_builder = form_builder
    @view_context = view_context
  end

  def notes
    markup(:div, class: 'notes') do |m|
      m.span '*', class: 'mark'
      m.text '印のついた項目は入力必須です'
    end
  end

  def text_field_block(name, label_text, options = {})
    markup(:div, class: 'form-group py-2') do |m|
      m << decorated_label(name, label_text, options)
      m << text_field(name, options.merge(class: 'form-control'))
      m << error_messages_for(name)
    end
  end

  def password_field_block(name, label_text, options = {})
    markup(:div, class: 'form-group py-2') do |m|
      m << decorated_label(name, label_text, options)
      m << password_field(name, options.merge(class: 'form-control'))
      m << error_messages_for(name)
    end
  end

  def date_field_block(name, label_text, options = {})
    markup(:div, class: 'form-group py-2') do |m|
      m << decorated_label(name, label_text, options)
      options = insert_datepicker(options.merge(class: 'form-control'))
      m << text_field(name, options))
      m << error_messages_for(name)
    end
  end

  def drop_down_list_block(name, label_text, choises, options = {})
    markup(:div, class: 'dropdown py-2') do |m|
      m << decorated_label(name,
                           label_text,
                           options.merge(class: 'form-control'))
      m << form_builder.select(name,
                               choises, { include_blank: true },
                               options.merge(class: 'form-control'))
      m << error_messages_for(name)
    end
  end

  def error_messages_for(name)
    markup do |m|
      object.errors.full_messages_for(name).each do |message|
        m.div(class: 'error-message') do |t|
          t.text message
        end
      end
    end
  end

  def decorated_label(name, label_text, options = {})
    label(
      name,
      label_text,
      class: options[:required] ? 'required' : nil
    )
  end

  def insert_datepicker(options)
    if options[:class].is_a?(String)
      classes = options[:class].strip.split + ['datepicker']
      options[:class] = classes.uniq.join(' ')
    else
      options[:class] = 'datepicker'
    end

    options
  end
end
