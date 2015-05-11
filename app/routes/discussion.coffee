`import Ember from 'ember'`

DiscussionRoute = Ember.Route.extend
  model: ->
    Ember.RSVP.hash
      broadcast: @store.findAll('broadcast').then (items) ->
        items.get('firstObject')

`export default DiscussionRoute`
