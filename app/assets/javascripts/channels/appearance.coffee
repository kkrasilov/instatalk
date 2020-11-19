App.appearance = App.cable.subscriptions.create "AppearanceChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('#online').html data['users'].map((user) -> "<li>#{user}</li>").join("\n")
