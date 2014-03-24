# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#
$(document).ready ->

  $('#desk_case').change ->
    desk_case_id = $('#desk_case').val()[0]
    #alert(desk_case_id)
    $.ajax
      url: '/desk_labels/' + desk_case_id + '/find.json',
      type: 'get',
      success: (data, textStatus, jqXHR) ->
        #debugger
        #console.log(data)
        $('#desk_labels').val(data['id'])
        #$.each data, (index, value) ->
          #$("#desk_labels option[value=" + value + "]").attr("selected", "selected")
        

