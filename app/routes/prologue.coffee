`import Ember from 'ember'`

PrologueRoute = Ember.Route.extend
  model: ->
    Ember.RSVP.hash
      broadcast: @store.findAll('broadcast').then (items) ->
        items.get 'firstObject'

`export default PrologueRoute`
