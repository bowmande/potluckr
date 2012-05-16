Potlucks = new Meteor.Collection("potlucks")

Session.set('id', null)
Session.set('editing_id', null)


Template.container.editing = -> 
  Session.get('editing_id')
  
Template.edit_potluck.items = ->
  potluck = Potlucks.findOne(Session.get('editing_id'))
  (potluck && potluck.items) || []
  
Template.edit_potluck.events = {}
Template.edit_potluck.events[okcancel_events('#new-name')] =
  make_okcancel_handler
    ok: (text, evt) ->
      pattern = /(\d*)/
      count = text.match(pattern)[0]
      item =
        name: text
        count: count
      Potlucks.update(Session.get('editing_id'), $addToSet: {items: item})
      evt.target.value = ""
  
