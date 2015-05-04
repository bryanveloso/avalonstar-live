`import Ember from 'ember'`
`import SocketMixin from 'live/mixins/socket'`

DashboardController = Ember.Controller.extend SocketMixin,
  latestHosts: (->
    @get('model.hosts').slice(0, 10)
  ).property('model.hosts.[]')

  latestRaids: (->
    @get('model.raids').slice(0, 10)
  ).property('model.raids.[]')

  latestTickets: (->
    @get('model.tickets').slice(0, 10)
  ).property('model.tickets.[]')

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

`export default DashboardController`
