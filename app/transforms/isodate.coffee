`import DS from 'ember-data'`

IsodateTransform = DS.Transform.extend
  deserialize: (serialized) ->
    if serialized
      moment(serialized).toDate()
    serialized

  serialize: (deserialized) ->
    if deserialized
      moment(deserialized).format()
    deserialized

`export default IsodateTransform`
