`import Ember from 'ember'`

GamingView = Ember.View.extend
  classNames: ['overlay__container']

  _scroll: ->
    container = @$('.chat-list')
    container.animate
      scrollTop: container.prop('scrollHeight')
    , 250

    # Reveal all messages.
    @$('.chat-line').removeClass('hidden')

  actions:
    scroll: ->
      Ember.run.debounce(@, @_scroll, 150, true)

`export default GamingView`
