`import Ember from 'ember'`

PrologueView = Ember.View.extend
  classNames: ['overlay__container', 'overlay--prologue']

  didInsertElement: ->
    # Instantiate looper.js.
    looper = @$('.looper')
    looper.looper
      'interval': 15000
    looper.looper('next')

`export default PrologueView`
