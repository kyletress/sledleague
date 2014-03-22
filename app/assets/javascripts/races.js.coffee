# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()
    elems = $(":input[id$='_position']").length
    $("input[id$='position']:last").val(elems)
    $("input[id$='athlete_name']").autocomplete
      source: $("input[id$='athlete_name']").data('autocomplete-source')
    
  $("input[id$='athlete_name']").autocomplete
    source: $("input[id$='athlete_name']").data('autocomplete-source')