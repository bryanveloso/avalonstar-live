`import Ember from 'ember'`
`import ENV from '../config/environment'`
### global moment, io ###

DashboardController = Ember.Controller.extend
  init: ->
    @setupSockets()

  latestHosts: (->
    @get('model.hosts').slice(0, 10)
  ).property('model.hosts.[]')

  latestRaids: (->
    @get('model.raids').slice(0, 10)
  ).property('model.raids.[]')

  notify: (endpoint, data) ->
    @get('socket').emit('event sent', data)

  # Actions.
  actions:
    triggerSubscription: ->
      event = 'subscription'
      @notify event,
        event: event
        username: @get 'subscriber'

    triggerResubscription: ->
      event = 'resubscription'
      @notify event,
        event: event
        username: @get 'resubscriber'

    triggerSubstreak: ->
      event = 'substreak'
      @notify event,
        event: event
        username: @get 'substreaker'
        length: @get 'length'

    triggerDonation: ->
      event = 'donation'
      @notify event,
        event: event
        username: @get 'donater'

    triggerHost: ->
      event = 'host'
      @notify event,
        event: event
        username: @get 'hoster'

  # Socket.io handling.
  socket: null
  setupSockets: ->
    # Set socket to an active socket.io instance.
    @set('socket', io.connect(ENV.APP.SOCKET_HOST))
    @get('socket').on 'connect', ->
      console.log 'Connected to the socket server.'

    @get('socket').on "subscription received", (data) =>
      console.log data

`export default DashboardController`
