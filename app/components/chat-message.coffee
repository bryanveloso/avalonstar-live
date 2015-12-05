`import Ember from 'ember'`

ChatMessageComponent = Ember.Component.extend
  classNameBindings: ['isHidden:hidden']
  classNames: ['chat-line']
  tagName: 'li'

  # Attribute bindings.
  attributeBindings: ['username:data-username']
  username: Ember.computed.alias('message.username')

  # Logic related to the display of chat messages.
  isHidden: true

  didInsertElement: ->
    @get('parentView').send('scroll')

    Ember.run.later (=>
      @set('isHidden', false)
    ), 150

    # During a normal episode, the DOM gets pretty inundated with `.chat-line`
    # elements. Eventually adding lines gets slow. So let's only ever show 5
    # (`maxMessages`) messages, removing the overflow from the DOM.
    maxMessages = 4
    linesToDelete = Ember.$('.chat-line').length - maxMessages

    if linesToDelete > 0
      i = 0
      while i < linesToDelete
        Ember.$('.chat-line').eq(0).addClass('hidden')
        i++

`export default ChatMessageComponent`
