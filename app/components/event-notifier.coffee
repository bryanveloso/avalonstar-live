`import Ember from 'ember'`
`import ENV from '../config/environment'`

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

    initialDelay = 1000
    transitionLength = 7000

    if obj
      @set('payload',
        'event': obj.event
        'username': obj.username
        'length': obj.length || null
        'message': @composeMessage(obj)
      )

      # We wait just a little bit in order for the template to be populated.
      # This is important since we record the dimensions of the final
      # presented overlay.
      Ember.run.later (=>
        # Explicitly set the dimensions of .notifier__container so we can
        # start moving things around.
        container = @$('.notifier__container')
        container.css
          'width': container.width(),
          'height': container.height()

        # Play the music!
        sound = new Audio("assets/audio/#{obj.event}.ogg")
        sound.volume = 0.4
        sound.play()

        # Add the class.
        @$('.notifier__container').addClass('active')
        @$(".square--icon__#{obj.event}").show()
      ), initialDelay

      Ember.run.later (=>
        # Clean everything up!
        container = @$('.notifier__container')
        container.css
          'width': '',
          'height': ''
      ), initialDelay + transitionLength

      # Remove the object from the pool.
      # This final delay is the length of the transition, plus 500ms.
      Ember.run.later (=>
        @$(".square--icon__#{obj.event}").hide()
        @$(".notifier__container").removeClass('active')

        pool.removeObject(obj)
        console.log "Number of remaining objects: #{pool.length}."
        console.log "Objects remaining: #{JSON.stringify pool}."
      ), initialDelay + transitionLength + 500

  composeMessage: (obj) ->
    messages = {
      'subscription': (obj) ->
        'welcome to the Crusaders!'
      'resubscription': (obj) ->
        'welcome back to the Crusaders!'
      'substreak': (obj) ->
        "thanks for #{obj.length} months of support!"
      'donation': (obj) ->
        'thank you for the donation!'
    }

    messages[obj.event](obj)

  # Socket.io handling.
  socket: null
  setupSockets: ->
    @set('socket', io.connect(ENV.APP.SOCKET_HOST))
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
