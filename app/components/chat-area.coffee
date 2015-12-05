`import Ember from 'ember'`

ChatAreaComponent = Ember.Component.extend Ember.PromiseProxyMixin,
  init: ->
    @_super()
    promise = @get('store').query 'message',
      limitToLast: 4
    return @set('promise', promise) if promise

  _scroll: ->
    container = @$('.chat-list')
    container.animate
      scrollTop: container.prop('scrollHeight')
    , 250

  actions:
    scroll: ->
      Ember.run.debounce(@, @_scroll, 150)

`export default ChatAreaComponent`
