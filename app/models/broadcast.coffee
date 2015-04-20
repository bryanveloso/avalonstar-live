`import DS from 'ember-data'`

Broadcast = DS.Model.extend
  number: DS.attr 'number'
  airdate: DS.attr 'date'
  status: DS.attr 'string'

  # ...
  games: DS.hasMany 'game', async: true

  formattedAirDate: (->
    moment(@get 'airdate').format 'LL'
  ).property('airdate')

`export default Broadcast`
