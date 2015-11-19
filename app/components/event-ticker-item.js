import Ember from 'ember';

export default Ember.Component.extend({
  classNameBindings: [':ticker-item', 'event'],
  tagName: ['li']
});
