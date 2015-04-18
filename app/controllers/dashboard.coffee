`import Ember from 'ember'`
### global moment ###

DashboardController = Ember.Controller.extend
  latestHosts: (->
    @get('model.hosts').slice(0, 10)
  ).property('model.hosts.[]')

  latestRaids: (->
    @get('model.raids').slice(0, 10)
  ).property('model.raids.[]')

  # Actions.
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

`export default DashboardController`
