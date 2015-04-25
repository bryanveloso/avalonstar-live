`import DS from 'ember-data'`

Game = DS.Model.extend
  name: DS.attr 'string'
  imageArt: DS.attr 'string'
  appearances: DS.attr 'number'

  # ...
  platform: DS.belongsTo 'platform', async: true

`export default Game`
