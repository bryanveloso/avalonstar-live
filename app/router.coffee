`import Ember from 'ember'`
`import config from './config/environment'`

Router = Ember.Router.extend
  location: config.locationType

Router.map ->
  # Controls.
  @route 'dashboard'

  # Overlays.
  @route 'gaming', path: 'overlay/gaming'
  @route 'prologue', path: 'overlay/prologue'
  @route 'discussion', path: 'overlay/discussion'

`export default Router`
