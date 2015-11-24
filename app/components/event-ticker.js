import Ember from 'ember';

export default Ember.Component.extend(Ember.PromiseProxyMixin, {
  classNameBindings: ['isHidden:ticker-list--hidden'],
  classNames: ['ticker-list'],
  tagName: ['ol'],

  init() {
    this._super();
    let promise = this.get('store').query('event', {
      orderBy: 'timestamp',
      limitToLast: 10
    });
    if (promise) {
      return this.set('promise', promise);
    }
  },

  // Logic related to the toggling of the ticker list. `delay` is used to run
  // a timer that is destroyed and recreated every time a new event is added.
  isHidden: true, // Is the ticker currently hidden?
  delay: 1000 * 60 * 5, // 5 minutes.

  _timerExpired() {
    this.set('isHidden', true);
  },
  setupTimer() {
    this._timer = Ember.run.later(this, this._timerExpired, this.get('delay'));
    this.set('isHidden', false);
  },
  removeTimer() {
    Ember.run.cancel(this._timer);
    delete this._timer;
  },

  actions: {
    resetTimer() {
      this.removeTimer();
      this.setupTimer();
    }
  }
});
