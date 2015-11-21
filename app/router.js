import Ember from 'ember';
import config from './config/environment';

const Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  // Controls.
  this.route('dashboard');

  // Overlays.
  this.route('discussion', {path: 'overlay/discussion'});
  this.route('gaming', {path: 'overlay/gaming'});
  this.route('prologue', {path: 'overlay/prologue'});

  this.route('ticker', {path: 'overlay/ticker'});
  this.route('notifier', {path: 'overlay/notifier'});
});

export default Router;
