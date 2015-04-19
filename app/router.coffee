`import Ember from 'ember'`
`import config from './config/environment'`

Router = Ember.Router.extend
  location: config.locationType

Router.map ->
  # Controls.
  @route 'dashboard'

  # Overlays.
  @route 'game', path: 'overlay/game'
  @route 'prologue', path: 'overlay/prologue'

`export default Router`
