# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#
$(document).ready ->

  $('#desk_labels').change ->
    $('.delete_label').fadeIn('slow')

  $('#desk_case').change ->
    desk_case_id = $('#desk_case').val()[0]
    #alert(desk_case_id)
    $.ajax
      url: '/desk_labels/' + desk_case_id + '/find.json',
      type: 'get',
      success: (data, textStatus, jqXHR) ->
        #debugger
        $('#desk_labels').val(data['id'])
        $('.delete_label').fadeIn('slow')
        $('.save_label').fadeIn('slow')

  $('#save_label').click (event)->
    event.preventDefault
    desk_case_id = $('#desk_case').val()[0]
    desk_label_ids = $('#desk_labels').val()
    dataToSend = {
      desk_case_id: desk_case_id,
      desk_label_ids: desk_label_ids
    }
    $.ajax
      url: '/desk_labels/save_relation',
      type: 'patch',
      data: dataToSend,
      dataType: 'json',
      success: (data, textStatus, jqXHR) ->
        console.log(data)
        $('.edit_label').append(data['text'])
    return false

  $('#delete_label').click (e) ->
    e.preventDefault
    desk_label_ids = $('#desk_labels').val()
    dataToSend = {desk_label_ids: desk_label_ids}
    $.ajax
      url: '/delete_label',
      type: 'delete',
      data: dataToSend,
      dataType: 'json',
      success: (data, textStatus, jqXHR) ->
        console.log(data)
        $('.edit_label').append(data['text'])
        #$('#fetch_label').click
    return false


        

