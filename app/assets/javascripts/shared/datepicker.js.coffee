$(document).on 'turbolinks:load', ->
  date = new Date()

  $.datepicker.setDefaults({
    dateFormat: 'yy-mm-dd',
    minDate: new Date(2017, 1, 1),
    maxDate: new Date(date.getFullYear() + 1, date.getMonth(), date.getDate() - 1)
  })

  $('.datepicker').datepicker()
