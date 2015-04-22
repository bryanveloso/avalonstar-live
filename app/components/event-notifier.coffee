`import Ember from 'ember'`

EventNotifierComponent = Ember.Component.extend
  classNames: ['event-notifier']

  didInsertElement: ->
    @setupSockets()

  # Pool handling.
  pool: []
  addEventToPool: (event, data) ->
    console.log "added #{event} with #{data} to pool!"
    @get('pool').pushObject(data)

  observePool: (->
    Ember.run.debounce(@, @handleEvent, 2000) if @get('pool').length
  ).observes('pool.[]')

  # Event handling.
  handleEvent: ->
    pool = @get('pool')
    object = pool.get('firstObject')
    @set('payload',
      'event': object.event
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
    event = 'subscription'
    @get('socket').on "#{event} received", (data) =>
      @addEventToPool(event, data)
      console.log data

  handleResubscription: ->
    # ...
    event = 'resubscription'
    @get('socket').on "#{event} received", (data) =>
      @addEventToPool(event, data)
      console.log data

  handleSubstreak: ->
    # ...
    event = 'substreak'
    @get('socket').on "#{event} received", (data) =>
      @addEventToPool(event, data)
      console.log data

  handleDonation: ->
    # ...
    event = 'donation'
    @get('socket').on "#{event} received", (data) =>
      @addEventToPool(event, data)
      console.log data

`export default EventNotifierComponent`
