$ ->
  $('#url_form').submit((event) ->
    event.preventDefault()
    $('#shortened').empty()
    $('#shortened').append "<h1>Generating Summary.... Please wait!</h1>"
    $.post('create', {url: $('#url').val()}).done((data)->
      $('#shortened').empty()
      data = JSON.parse(data)
      window.article = data
      $('#shortened').append "<button id=\"post_it\">Post This</button>"
      $('#post_it').click redirect
      $('#shortened').append "<p>#{data.summary}</p>"
      $('#shortened').append "<p>Original Size:#{data.old_length} | New Size:#{data.new_length} | #{data.compression_rate.toFixed(2)}% Shorter</p>"
    ).fail(->
      $('#shortened').empty()
      $('#shortened').append "<h1>Unable to generate summary please try another site</h1>"
    )
  )

redirect = ->
  window.location = "/posts/new?article_id=#{window.article.id}"
