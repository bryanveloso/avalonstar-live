`import Ember from 'ember'`

PrologueRoute = Ember.Route.extend
  model: ->
    Ember.RSVP.hash
      broadcast: @store.findAll('broadcast').then (items) ->
        items.get('firstObject')
      messages: @store.find('message')

`export default PrologueRoute`
