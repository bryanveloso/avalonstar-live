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
      action = 'subscription'
      @notify action,
        action: action
        username: @get 'subscriber'

    triggerResubscription: ->
      action = 'resubscription'
      @notify action,
        action: action
        username: @get 'resubscriber'

    triggerSubstreak: ->
      action = 'substreak'
      @notify action,
        action: action
        username: @get 'substreaker'
        length: @get 'length'

    triggerDonation: ->
      action = 'donation'
      @notify action,
        action: action
        username: @get 'donater'

`export default DashboardController`
