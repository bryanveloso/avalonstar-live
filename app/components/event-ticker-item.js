import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['ticker-item', 'ticker-item--hidden'],
  // classNames: ['ticker-item'],
  tagName: ['li'],

  // Attribute Bindings
  attributeBindings: ['type:data-event'],
  type: Ember.computed.alias('event.event'),

  didInsertElement() {
    // A new event here should reset the idle timer of the parent.
    // this.get('parentView').send('...')

    //
    this.$().removeClass('ticker-item--hidden');

    // Store the width of the element in a `data-width` attribute.
    this.$().attr('data-width', this.$().width());

    // If there's a tip, mark it as visible for 10 seconds.
    let tickerMessage = this.$('.ticker__message');
    let toggleClass = 'ticker__message--hidden';

    tickerMessage.removeClass(toggleClass)
    Ember.run.later((function() {
      tickerMessage.addClass(toggleClass)
    }), 5000);
  },

  eventIsTip: function() {
    return this.get('event.event') === 'tip';
  }.property('person')
});
