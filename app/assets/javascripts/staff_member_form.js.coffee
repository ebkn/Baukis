$(document).on 'turbolinks:load', ->
  $enable_button  = $('#enable-password_field-button')
  $disable_button = $('#disable-password_field-button')
  $password_form  = $('#staff_member_password')
  $password_label = $('label[for=staff_member_password]')

  $enable_button.on 'click', ->
    $(this).hide()
    $disable_button.show()
    $password_form.show()
    $password_form.removeAttr('disabled')
    $password_label.addClass('required')

  $disable_button.on 'click', ->
    $(this).hide()
    $enable_button.show()
    $password_form.hide()
    $password_form.attr('dusabled', 'disabled')
    $password_label.removeClass('required')
