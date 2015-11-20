import Ember from 'ember';

export default Ember.Component.extend(Ember.PromiseProxyMixin, {
  classNames: ['ticker-list'],
  tagName: ['ol'],

  init() {
    this._super();
    let promise = this.get('store').findAll('event');
    if (promise) {
      return this.set('promise', promise);
    }
  }
});
