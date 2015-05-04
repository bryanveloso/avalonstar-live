`import Ember from 'ember'`

DashboardRoute = Ember.Route.extend
  model: ->
    Ember.RSVP.hash
      broadcast: @store.findAll('broadcast').then (items) ->
        items.get('firstObject')
      hosts: @store.findAll 'host'
      raids: @store.findAll 'raid'
      tickets: @store.findAll 'ticket'

  actions:
    triggerRefresh: ->
      console.log 'Refreshing route.'
      @refresh()

`export default DashboardRoute`
