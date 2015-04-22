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
    Ember.run.debounce(@, @handleEvent, 5000, false) if @get('pool').length
  ).observes('pool.[]')

  # Event handling.
  handleEvent: ->
    pool = @get('pool')
    object = pool.get('firstObject')
    @set('payload',
      'event': object.event
      'username': object.username
      'length': object.length || null
      'message': @composeMessage(object)
    )
    console.log JSON.stringify @get('payload')

    Ember.$(".event-message__#{object.event}").addClass('active')

    Ember.run.later (->
      Ember.$(".event-message__#{object.event}").removeClass('active')
      pool.removeObject(object)
    ), 2000

    console.log "Number of remaining objects: #{pool.length}."
    console.log "Objects remaining: #{JSON.stringify pool}."

  composeMessage: (object) ->
    messages = {
      'subscription': (object) ->
        'welcome to the Crusaders!'
      'resubscription': (object) ->
        'welcome back to the Crusaders!'
      'substreak': (object) ->
        "#{object.length} months as a Crusader!"
      'donation': (object) ->
        'thank you for the donation!'
    }

    messages[object.event](object)

  # Socket.io handling.
  socket: null
  setupSockets: ->
    @set('socket', io.connect('ws://localhost:5000'))
    @get('socket').on 'connect', ->
      console.log 'Connected to the socket server.'

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
