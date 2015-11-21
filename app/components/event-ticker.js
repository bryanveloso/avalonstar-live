import Ember from 'ember';

export default Ember.Component.extend(Ember.PromiseProxyMixin, {
  classNames: ['ticker-list', 'ticker-list--hidden'],
  tagName: ['ol'],

  init() {
    this._super();
    let promise = this.get('store').query('event', {
      orderBy: 'timestamp',
    });
    if (promise) {
      return this.set('promise', promise);
    }
  },

  actions: {
    resetTimer() {
      let ticker = this.$();
      let toggleClass = 'ticker-list--hidden';
      ticker.removeClass(toggleClass);
      Ember.run.later((function() {
        ticker.addClass(toggleClass);
      }), 5000);    
    }
  }
});
