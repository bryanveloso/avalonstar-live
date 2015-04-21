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
    Ember.$.ajax
      type: 'POST'
      url: "#{ENV.API_BASE}/pusher/#{endpoint}/"
      data: data
    console.log "Triggering #{endpoint} for #{data.username}."

  # Actions.
  actions:
    triggerSubscription: ->
      @notify 'subscription', username: @get 'subscriber'

    triggerResubscription: ->
      @notify 'resubscription', username: @get 'resubscriber'

    triggerSubstreak: ->
      @notify 'substreak',
        username: @get 'substreaker'
        length: @get 'length'

    triggerDonation: ->
      @notify 'donation', username: @get 'donater'

`export default DashboardController`
