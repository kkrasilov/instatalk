jQuery(document).on 'turbolinks:load', ->
  messages = $('#messages')

  if messages.length > 0
    createRoomChannel messages.data('room-id')

  $(document).on 'keypress', '#message_body', (event) ->
    message = event.target.value
    if event.keyCode is 13
      if message != ''
        App.room.speak(message)
        event.target.value = ""
      event.preventDefault()


createRoomChannel = (roomId) ->
  App.room = App.cable.subscriptions.create {channel: "RoomChannel", roomId: roomId},
    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      if data.user
        current_user = data.user
        element_user = $("#room-user").find("[data-id=#{current_user.id}]")
        subscribed = data.subscribed

        if subscribed && element_user.length == 0
          $("#room-user").append("<li data-id=#{current_user.id}>#{current_user.nickname}</li>")
        else if !subscribed && element_user.length > 0
          element_user.remove()

      # Called when there's incoming data on the websocket for this channel
      $('#messages').append data['message']
      $('#messages').scrollTop($('#messages').prop('scrollHeight'))

    speak: (message) ->
      @perform 'speak', message: message

    $('#leave').on "click", ->
      App.room.unsubscribe()
