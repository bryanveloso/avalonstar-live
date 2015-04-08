`import DS from 'ember-data'`

Raid = DS.Model.extend
  broadcast: DS.attr 'number'
  timestamp: DS.attr 'date'
  username: DS.attr 'string'
  game: DS.attr 'string'

`export default Raid`
