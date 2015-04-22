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

  # Event handling.
  handleEvent: Ember.observer 'pool.firstObject', ->
    pool = @get('pool')
    obj = pool.get('firstObject')
    if obj
      @set('payload',
        'event': obj.event
        'username': obj.username
        'length': obj.length || null
        'message': @composeMessage(obj)
      )

      Ember.$(".event-message__#{obj.event}").addClass('active')

      Ember.run.later (->
        Ember.$(".event-message__#{obj.event}").removeClass('active')
      ), 2000

      Ember.run.later (->
        pool.removeObject(obj)
        console.log "Number of remaining objects: #{pool.length}."
        console.log "Objects remaining: #{JSON.stringify pool}."
      ), 5000

  composeMessage: (obj) ->
    messages = {
      'subscription': (obj) ->
        'welcome to the Crusaders!'
      'resubscription': (obj) ->
        'welcome back to the Crusaders!'
      'substreak': (obj) ->
        "#{obj.length} months as a Crusader!"
      'donation': (obj) ->
        'thank you for the donation!'
    }

    messages[obj.event](obj)

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
