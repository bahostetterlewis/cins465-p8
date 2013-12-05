# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "ready page:change", ->
  #slightly modified from the flat-ui help on github
  $(".input-group").on("focus", "input",->
    $(this).closest(".form-group").addClass "focus"
  ).on "blur", "input", ->
    $(this).closest(".form-group").removeClass "focus"

  $(".clickable").click ->
    window.location.href = window.location.origin + $(this).data("location")