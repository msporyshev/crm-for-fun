# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->

  $(".opened_closed_select").change(
    () ->
      $.ajax({
        type: 'PUT'
        url: 'tasks/' + this.id,
        data: {
          task: { closed: this.value }
        }
      })
      false
  )
  false