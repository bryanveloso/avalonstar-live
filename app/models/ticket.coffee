`import DS from 'ember-data'`

Ticket = DS.Model.extend
  name: DS.attr 'string'
  displayName: DS.attr 'string'
  created: DS.attr 'isodate'
  updated: DS.attr 'isodate'
  streak: DS.attr 'number'

  status: (->
    # If the user has a substreak, display that.
    if @get('streak') > 1
      "#{@get('streak')}"
    # If not, then see if they're a new subscriber.
    else if moment(@get('updated')).calendar() is moment(@get('created')).calendar()
      "new"
    # If they're not new, then it's a resubscribe.
    else
      "resub"
  ).property('status')

`export default Ticket`
