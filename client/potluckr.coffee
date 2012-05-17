Potlucks = new Meteor.Collection("potlucks")

Session.set('id', null)
Session.set('editing_id', null)


Template.container.editing = -> 
  Session.get('editing_id')
  
Template.edit_potluck.items = ->
  potluck = Potlucks.findOne(Session.get('editing_id'))
  (potluck && potluck.items.reverse()) || []

  
Template.edit_potluck.events = {}
Template.edit_potluck.events[okcancel_events('#new-name')] =
  make_okcancel_handler
    ok: (text, evt) ->
      pattern = /(\d+)/g
      count = text.match(pattern)
      item =
        name: get_name(text)
        count: (count && count[0]) || 1
      Potlucks.update(Session.get('editing_id'), $addToSet: {items: item})
      evt.target.value = ""
  
# http://localhost:3000/091e62e9-671c-4fd1-94ce-35ba7985c2a3/edit

Template.view_potluck.items = ->
  potluck = Potlucks.findOne(Session.get('id'))
  (potluck && potluck.items.reverse()) || []

Template.view_item.count_times = -> [1..this.count]