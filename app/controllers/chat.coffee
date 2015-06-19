`import Ember from 'ember'`

ChatController = Ember.Controller.extend Ember.PromiseProxyMixin,
  init: ->
    @_super()
    promise = @store.find 'message',
      limitToLast: 20
    return @set('promise', promise) if promise

`export default ChatController`
