`import Ember from 'ember'`

PrologueView = Ember.View.extend
  classNames: ['overlay__container', 'overlay--prologue']

  didInsertElement: ->
    @$('.looper').looper('next')

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

`export default PrologueView`
