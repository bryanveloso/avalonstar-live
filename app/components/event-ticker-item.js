import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['ticker-item'],
  tagName: ['li'],

  // Attribute Bindings
  attributeBindings: ['type:data-event'],
  type: Ember.computed.alias('event.event'),

  didInsertElement() {
    console.log(this.$());
  }
});
