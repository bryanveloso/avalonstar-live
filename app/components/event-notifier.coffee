`import Ember from 'ember'`

EventNotifierComponent = Ember.Component.extend
  classNames: ['event-notifier']

  didInsertElement: ->
    @setupSockets()

  # Pool handling.
  pool: []
  addActionToPool: (action, data) ->
    console.log "added #{action} with #{data} to pool!"
    @get('pool').pushObject(data)

  observePool: (->
    Ember.run.debounce(@, @handleEvent, 2000) if @get('pool').length
  ).observes('pool.[]')

  # Event handling.
  handleEvent: ->
    pool = @get('pool')
    object = pool.get('firstObject')
    @set('payload',
      'action': object.action
      'username': object.username
      'length': object.length || null
    )

    console.log "Number of remaining objects: #{pool.length}."
    console.log "Objects remaining: #{JSON.stringify pool}."
    pool.removeObject(object)

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
    action = 'subscription'
    @get('socket').on "#{action} received", (data) =>
      @addActionToPool(action, data)
      console.log data

  handleResubscription: ->
    # ...
    action = 'resubscription'
    @get('socket').on "#{action} received", (data) =>
      @addActionToPool(action, data)
      console.log data

  handleSubstreak: ->
    # ...
    action = 'substreak'
    @get('socket').on "#{action} received", (data) =>
      @addActionToPool(action, data)
      console.log data

  handleDonation: ->
    # ...
    action = 'donation'
    @get('socket').on "#{action} received", (data) =>
      @addActionToPool(action, data)
      console.log data

`export default EventNotifierComponent`
