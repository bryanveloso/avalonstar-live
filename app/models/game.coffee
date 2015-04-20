`import DS from 'ember-data'`

Game = DS.Model.extend
  name: DS.attr 'string'
  imageArt: DS.attr 'string'

`export default Game`
