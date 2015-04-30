`import Ember from 'ember'`

GamingRoute = Ember.Route.extend
  model: ->
    Ember.RSVP.hash
      broadcast: @store.findAll('broadcast').then (items) ->
        items.get('firstObject')
      hosts: @store.findAll 'host'
      raids: @store.findAll('raid').then (items) ->
        items.get('firstObject')

      # ..
      messages: @store.find('message')

`export default GamingRoute`
