`import Ember from 'ember'`
`import ENV from '../config/environment'`

SocketMixin = Ember.Mixin.create
  init: ->
    @_super()

    # Set socket to an active socket.io instance.
    @set('socket', io.connect(ENV.APP.SOCKET_HOST))
    @get('socket').on 'connect', ->
      console.log 'Connected to the socket server.'

`export default SocketMixin`
