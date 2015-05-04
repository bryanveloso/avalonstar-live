`import DS from 'ember-data'`

IsodateTransform = DS.Transform.extend
  deserialize: (serialized) ->
    if serialized
      moment(serialized).toDate()

  serialize: (deserialized) ->
    if deserialized
      moment(deserialized).format()

`export default IsodateTransform`
