`import Ember from 'ember'`

DashboardRoute = Ember.Route.extend
  model: ->
    Ember.RSVP.hash
      broadcast: @store.findAll('broadcast').then (items) ->
        items.get('firstObject')
      hosts: @store.findAll 'host'
      raids: @store.findAll 'raid'

`export default DashboardRoute`
