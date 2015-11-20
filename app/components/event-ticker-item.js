import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['ticker-item', 'ticker-item--hidden'],
  tagName: ['li'],

  // Attribute Bindings
  attributeBindings: ['type:data-event'],
  type: Ember.computed.alias('event.event'),

  didInsertElement() {
    this.$().attr('data-width', this.$().width());
    this.$().removeClass('ticker-item--hidden');

    // Store the width of the element in a `data-width` attribute.
  },

  eventIsTip: function() {
    return this.get('event.event') === 'tip';
  }.property('person')
});
