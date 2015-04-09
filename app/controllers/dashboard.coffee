`import Ember from 'ember'`
`import { Bindings } from 'ember-pusher/bindings'`
`import { ClientEvents } from 'ember-pusher/client_events'`
### global moment ###

DashboardController = Ember.Controller.extend(Bindings, ClientEvents,
  latestHosts: (->
    @get('model.hosts').slice(0, 10)
  ).property('model.hosts.[]')

  latestRaids: (->
    @get('model.raids').slice(0, 10)
  ).property('model.raids.[]')

  # Actions.
  PUSHER_SUBSCRIPTIONS: {
    live: ['subscribed']
  }
  actions:
    triggerSubscription: ->
      username = @get 'username'
      console.log "Triggering subscription for #{username}"

      channel = @pusher.channelFor('live')
      channel.trigger('client-subscribed')
      # @pusherTrigger 'live', 'subscribed',

    triggerResubscription: ->
      username = @getProperties 'username'
      console.log 'Resubscription'

    triggerSubstreak: ->
      username = @getProperties 'username'
      console.log 'Substreak'

    triggerDonation: ->
      username = @getProperties 'username'
      console.log 'Donation'
)

`export default DashboardController`
