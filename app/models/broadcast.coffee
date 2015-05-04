`import DS from 'ember-data'`

Broadcast = DS.Model.extend
  number: DS.attr 'number'
  airdate: DS.attr 'isodate'
  status: DS.attr 'string'
  series: DS.attr 'string'

  isCharity: DS.attr 'boolean'
  isMarathon: DS.attr 'boolean'

  # ...
  games: DS.hasMany 'game', async: true

  formattedAirDate: (->
    moment(@get 'airdate').format 'LL'
  ).property('airdate')

`export default Broadcast`
