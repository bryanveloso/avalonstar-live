`import Ember from 'ember'`
`import ENV from '../config/environment'`
### global moment, io ###

DashboardController = Ember.Controller.extend
  socket: null

  init: ->
    # Set socket to an active socket.io instance.
    @set('socket', io.connect('ws://socket.avalonstar.tv'))
    @get('socket').on 'connect', ->
      console.log 'hello!'

  latestHosts: (->
    @get('model.hosts').slice(0, 10)
  ).property('model.hosts.[]')

  latestRaids: (->
    @get('model.raids').slice(0, 10)
  ).property('model.raids.[]')

  notify: (endpoint, data) ->
    @get('socket').emit("#{endpoint} sent", data)

    Ember.$.ajax
      type: 'POST'
      url: "#{ENV.API_BASE}/pusher/#{endpoint}/"
      data: data
    console.log "Triggering #{endpoint} for #{data.username}."

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

`export default DashboardController`
