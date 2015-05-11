`import Ember from 'ember'`

ChatController = Ember.Controller.extend Ember.PromiseProxyMixin,
  init: ->
    @_super()
    promise = @store.find('message')
    return @set('promise', promise) if promise

`export default ChatController`
