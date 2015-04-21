`import Ember from 'ember'`

EventNotifierComponent = Ember.Component.extend
  didInsertElement: ->
    @setupSockets()

  # Pool handling.
  pool: []
  addEventToPool: (event, data) ->



  # Socket.io handling.
  socket: null
  setupSockets: ->
    @set('socket', io.connect('ws://localhost:5000'))
    @get('socket').on 'connect', ->
      console.log 'hello!'

    #...
    @handleSubscription()
    @handleResubscription()
    @handleSubstreak()
    @handleDonation()

  handleSubscription: ->
    # ...
    @get('socket').on 'subscription received', (data) ->
      console.log data

  handleResubscription: ->
    # ...
    @get('socket').on 'resubscription received', (data) ->
      console.log data

  handleSubstreak: ->
    # ...
    @get('socket').on 'subtreak received', (data) ->
      console.log data

  handleDonation: ->
    # ...
    @get('socket').on 'donation received', (data) ->
      console.log data

`export default EventNotifierComponent`
