`import Ember from 'ember'`
`import config from './config/environment'`

Router = Ember.Router.extend
  location: config.locationType

Router.map ->
  # Controls.
  @route 'dashboard'

  # Overlays.
  @route 'discussion', path: 'overlay/discussion'
  @route 'gaming', path: 'overlay/gaming'
  @route 'notifier', path: 'overlay/notifier'
  @route 'prologue', path: 'overlay/prologue'

`export default Router`
