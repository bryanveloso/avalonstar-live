`import Ember from 'ember'`
`import config from './config/environment'`

Router = Ember.Router.extend
  location: config.locationType

Router.map ->
  @route 'dashboard'
  @route 'game', path: 'overlay/game'

`export default Router`
