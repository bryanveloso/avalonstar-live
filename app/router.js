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
  this.route('notifier', {path: 'overlay/notifier'});
  this.route('prologue', {path: 'overlay/prologue'});
});

export default Router;
