import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['ticker-item', 'ticker-item--hidden'],
  // classNames: ['ticker-item'],
  tagName: ['li'],

  // Attribute Bindings
  attributeBindings: ['type:data-event'],
  type: Ember.computed.alias('event.event'),

  _addEvent() {
    // A new event here should reset the idle timer of the parent.
    this.get('parentView').send('resetTimer');

    // Store the width of the element in a `data-width` attribute.
    this.$().attr('data-width', this.$().width());

    // ...
    // (We should wait a second here.)
    this.$().removeClass('ticker-item--hidden');

    /*
      Animation Plan.
      1) Instantiate off-screen (negative margin) -or- create a 1px wide element.
      2) Move element on-screen -or- grow element to size of data-width.
      3) Move in other things.
    */

    // If the event is a tip, mark it as visible for 10 seconds.
    let tickerMessage = this.$('.ticker__message');
    let toggleClass = 'ticker__message--hidden';

    let messageDelay = 1000 * 60 * 1;
    tickerMessage.removeClass(toggleClass);
    Ember.run.later((function() {
      tickerMessage.addClass(toggleClass);
    }), messageDelay);
  },

  didInsertElement() {
    // This delay is determined by the length of a normal notifier.
    let delay = 1000 * 8;  // 8 seconds.
    Ember.run.later((() => { this._addEvent(); }), delay);
  },

  eventIsTip: function() {
    return this.get('event.event') === 'tip';
  }.property('person')
});
