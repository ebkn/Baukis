$(document).on 'turbolinks:load', ->
  $enable_button = $('#enable-password_field-button')
  $disable_button = $('#disable-password_field-button')
  $password_form = $('#form_customer_password')
  $password_label = $('label[for=form_customer_password]')

  $home_address_check_box = $('input#form_inputs_home_address')
  $work_address_check_box = $('input#form_inputs_work_address')

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

  $home_address_check_box.on 'click', ->
    toggle_home_address_fields()

  $work_address_check_box.on 'click', ->
    toggle_work_address_fields()

  toggle_home_address_fields = ->
    checked = $home_address_check_box.prop('checked')
    $('fieldset#home-address-fields input').prop('disabled', !checked)
    $('fieleset#home-address-fieles select').prop('disabled', !checked)

    if checked
      $('fieldset.home_address_fields').show()
    else
      $('fieldset.home_address_fields').hide()

  toggle_work_address_fields = ->
    checked = $work_address_check_box.prop('checked')
    $('fieldset#work-address-fields input').prop('disabled', !checked)
    $('fieleset#work-address-fieles select').prop('disabled', !checked)

    if checked
      $('fieldset.work_address_fields').show()
    else
      $('fieldset.work_address_fields').hide()

  toggle_home_address_fields()
  toggle_work_address_fields()
