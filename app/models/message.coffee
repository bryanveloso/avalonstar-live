`import DS from 'ember-data'`

Message = DS.Model.extend
  color: DS.attr 'string'
  display_name: DS.attr 'string'
  emotes: DS.attr 'string'
  is_action: DS.attr 'boolean'
  message: DS.attr 'string'
  roles: DS.attr 'string'
  timestamp: DS.attr 'number'
  username: DS.attr 'string'
  version: DS.attr 'number'

  # Roles.
  role: DS.attr 'string'
  subscriber: DS.attr 'boolean'
  turbo: DS.attr 'boolean'

  # Computed properties.
  emote_list: (->
    list = @get('emotes')?.split(',')
    return list or []
  ).property('emotes')
  name: (->
    display_name = @get('display_name')
    if display_name? and display_name isnt 'true'
      display_name
    else
      @get('username')
  ).property('name')

  # Rendering/Display properties.
  style: (->
    color = @get('color')
    "color: #{color}".htmlSafe()
  ).property('color')

  # Is this message purged?
  is_purged: DS.attr 'boolean'

  # Is this message from twitchnotify?
  # (For subscription notifications.)
  is_notify: (->
    username = @get('username')
    true if username is 'twitchnotify'
  ).property('is_notify')

`export default Message`
