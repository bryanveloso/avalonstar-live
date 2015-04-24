`import Ember from 'ember'`

PrologueView = Ember.View.extend
  _scroll: ->
    console.log 'also called!'
    container = @$('.chat-list')
    console.log container
    container.animate
      scrollTop: container.prop('scrollHeight')
    , 250

    # Reveal all messages.
    @$('.chat-line').removeClass('hidden')

  actions:
    scroll: ->
      console.log 'called!'
      Ember.run.debounce(@, @_scroll, 150, true)

`export default PrologueView`
