`import Ember from 'ember'`

DashboardController = Ember.Controller.extend
  latestHosts: (->
    @get('model.hosts').slice(0, 10)
  ).property('model.hosts.[]')

  latestRaids: (->
    @get('model.raids').slice(0, 10)
  ).property('model.raids.[]')

`export default DashboardController`
