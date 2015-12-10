import Ember from 'ember';

export default Ember.Component.extend(Ember.PromiseProxyMixin, {
  init() {
    this._super();
    let promise = this.get('store').query('message', {
      limitToLast: 4
    });
    if (promise) {
      return this.set('promise', promise);
    }
  },

  _scroll() {
    let container = this.$('.chat-list');
    container.animate({
      scrollTop: container.prop('scrollHeight')
    }, 250);
  },

  actions: {
    scroll() {
      Ember.run.debounce(this, this._scroll, 150);
    }
  }
});
