import Ember from 'ember';

export default Ember.Component.extend({
  classNameBindings: ['isHidden:ticker-item--hidden:ticker-item--visible'],
  classNames: ['ticker-item'],
  tagName: ['li'],

  // Attribute Bindings
  attributeBindings: ['type:data-event'],
  type: Ember.computed.alias('event.event'),

  // Logic related to the display of ticker list items.
  isHidden: true,

  _addEvent() {
    // A new event here should reset the idle timer of the parent.
    this.get('parentView').send('resetTimer');
    Ember.run.later((() => { this.set('isHidden', false); }), 1000);

    // If the event is a tip, mark it as visible for 10 seconds.
    let tickerMessage = this.$('.ticker__message');
    let toggleClass = 'ticker__message--hidden';

    let appearDelay = 1000 * 2; // 2 seconds.
    let messageDelay = 1000 * 60 * 1; // 1 minute.
    Ember.run.later((function() { tickerMessage.removeClass(toggleClass); }), appearDelay);
    Ember.run.later((function() { tickerMessage.addClass(toggleClass); }), appearDelay + messageDelay);
  },

  didInsertElement() {
    // This delay is determined by the length of a normal notifier.
    let delay = 1000 * 8;  // 8 seconds.
    if (this.get('event.event') === 'follow') { delay = 1000 * 2; }  // 2 seconds.
    Ember.run.later((() => { this._addEvent(); }), delay);
  },

  eventIsTip: function() {
    return this.get('event.event') === 'tip';
  }.property('person')
});
