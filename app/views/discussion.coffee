`import Ember from 'ember'`

DiscussionView = Ember.View.extend
  classNames: ['overlay__container', 'overlay--discussion']

  didInsertElement: ->
    # Instantiate looper.js.
    looper = @$('.looper')
    looper.looper
      'interval': 15000
    looper.looper('next')

`export default DiscussionView`
