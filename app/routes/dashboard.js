import Ember from 'ember';

export default Ember.Route.extend({
  model() {
    return Ember.RSVP.hash({
      events: this.store.findAll('event'),

      broadcast: this.store.findAll('broadcast').then(function(items) {
        return items.get('firstObject');
      }),
      hosts: this.store.findAll('host'),
      raids: this.store.findAll('raid'),
      tickets: this.store.findAll('ticket')
    });
  },

  actions: {
    triggerRefresh() {
      console.log('Refreshing route.');
      return this.refresh();
    }
  }
});
