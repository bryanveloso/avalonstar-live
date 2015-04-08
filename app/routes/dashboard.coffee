`import Ember from 'ember'`

DashboardRoute = Ember.Route.extend
  model: ->
    Ember.RSVP.hash
      hosts: @store.findAll 'host'
      raids: @store.findAll 'raid'

`export default DashboardRoute`
