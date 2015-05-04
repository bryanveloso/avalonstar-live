`import Ember from 'ember'`
`import SocketMixin from '../../../mixins/socket'`
`import { module, test } from 'qunit'`

module 'SocketMixin'

# Replace this with your real tests.
test 'it works', (assert) ->
  SocketObject = Ember.Object.extend SocketMixin
  subject = SocketObject.create()
  assert.ok subject
