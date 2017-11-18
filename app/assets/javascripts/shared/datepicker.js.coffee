$(document).on 'turbolinks:load', ->
  date = new Date()

  $.datepicker.setDefaults({
    dateFormat: 'yy-mm-dd',
    minDate: new Date(2017, 1, 1).
    maxDate: new Date(d.getFullYear() + 1, d.getMonth(), d.getDate() - 1)
  })

  $('.datepicker').datepicker()
