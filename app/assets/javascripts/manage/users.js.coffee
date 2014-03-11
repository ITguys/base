# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('.addr_province').change (e) ->
    p = $(e.target)
    $.ajax "/addresses/" + p.val() + "/cities",
      success: (data) ->
        p.next().html("<option></option>"+data)
        p.next().next().html(null)
  $('.addr_city').change (e) ->
    c = $(e.target)
    $.ajax "/addresses/" + c.val() + "/districts",
      success: (data) ->
        c.next().html(data)
