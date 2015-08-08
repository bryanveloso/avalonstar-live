`import Ember from 'ember'`

ChatAreaComponent = Ember.Component.extend Ember.PromiseProxyMixin,
  init: ->
    @_super()
    promise = @get('store').find 'message',
      limitToLast: 20
    return @set('promise', promise) if promise

  _scroll: ->
    container = @$('.chat-list')
    container.animate
      scrollTop: container.prop('scrollHeight')
    , 250

    # Reveal all messages.
    @$('.chat-line').removeClass('hidden')

  actions:
    scroll: ->
      Ember.run.debounce(@, @_scroll, 150)

`export default ChatAreaComponent`
