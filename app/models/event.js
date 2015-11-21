import DS from 'ember-data';

export default DS.Model.extend({
  event: DS.attr('string'),
  username: DS.attr('string'),

  // Substreak specific.
  length: DS.attr('number'),

  // Tip specific.
  message: DS.attr('string'),
  amount: DS.attr('string')
});
