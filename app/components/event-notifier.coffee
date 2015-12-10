`import Ember from 'ember'`
`import SocketMixin from 'live/mixins/socket'`

EventNotifierComponent = Ember.Component.extend SocketMixin,
  classNames: ['event-notifier']

  didInsertElement: ->
    @setupSockets()
    @setupDonationListener()

  # Pool handling.
  pool: []
  addEventToPool: (data) ->
    console.log "added #{data.event} with #{JSON.stringify data} to pool!"
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

        # Queue up the music!
        if obj.event != 'host'
          sound = new Audio("assets/audio/#{obj.event}.ogg")
          sound.volume = 1.0
          sound.addEventListener('canplaythrough', =>
            # Play the sound when it's loaded. This makes sure the
            # animation is in sync with the notifier.
            sound.play()

            # Add the class.
            @$('.notifier__container').addClass('active')
          , false)
        else
          @$('.notifier__container').addClass('active')

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
        @$(".notifier__container").removeClass('active')

        pool.removeObject(obj)
        console.log "Number of remaining objects: #{pool.length}."
        console.log "Objects remaining: #{JSON.stringify pool}."
      ), initialDelay + transitionLength + 1000

  composeMessage: (obj) ->
    messages = {
      'subscription': (obj) ->
        'welcome to the Crusaders!'
      'resubscription': (obj) ->
        'welcome back to the Crusaders!'
      'substreak': (obj) ->
        "thanks for #{obj.length} months of support!"
      'donation': (obj) ->
        "thank you for the $#{obj.amount} tip!"
      'host': (obj) ->
        'thank you for the host!'
      'raid': (obj) ->
        'thank you for the raid!'
    }

    messages[obj.event](obj)

  # Donation handling.
  setupDonationListener: ->
    event = 'donation'
    es = new EventSource("https://imraising.tv/api/v1/listen?apikey=nuZOkYmLF37yQJdzNLWLRA")
    es.addEventListener 'donation.add', (e) =>
      response = JSON.parse(e.data)
      data =
        'event': 'donation'
        'username': response.nickname
        'message': response.message
        'amount': response.amount.display.total
      @addEventToPool(data)
      console.log data

  # Socket.io handling.
  setupSockets: ->
    # Handle events being received from the Socket.io server.
    @get('socket').on 'event received', (data) =>
      @addEventToPool(data)
      console.log data

`export default EventNotifierComponent`
