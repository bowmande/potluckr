Potlucks = new Meteor.Collection("potlucks")
Items = new Meteor.Collection("items")

Session.set('id', null)
Session.set('editing_id', null)
Session.set('item_id', null)


Template.container.editing = -> 
  Session.get('editing_id')
  
Template.edit_potluck.url = -> 
  "http://potluckr.meteor.com/#{Session.get('editing_id')}"
  
Template.edit_potluck.items = ->
	items = Items.find({pid: Session.get('editing_id')}).fetch()
	
	results = {}
	_.each items, (item) ->
	  if _.include(_.keys(results), item.title)
	    results[item.title].count++
    else
      results[item.title] = item
      results[item.title].count = 1
  _.values(results)
  
Template.edit_potluck.events = {}
Template.edit_potluck.events[okcancel_events('#new-name')] =
  make_okcancel_handler
    ok: (text, evt) ->
      pattern = /(\d+)/g
      count = text.match(pattern)
      times = (count && count[0]) || 1
      for i in [1..times]  
        item =
          title: get_name(text)
          pid: Session.get('editing_id')
          name: ''
          email: ''
        Items.insert(item)
      evt.target.value = ""
  
# http://localhost:3000/091e62e9-671c-4fd1-94ce-35ba7985c2a3/edit

Template.view_potluck.items = ->
	Items.find({pid: Session.get('id')}).fetch()
	
Template.view_potluck.url = -> 
  "http://potluckr.meteor.com/#{Session.get('id')}"
  
Template.view_potluck.name_visible = -> if name == '' then '' else 'style="display:none;"'

Template.view_potluck.events =
  'click': (evt) ->
    $(evt.target).children('.person').focus()
  'focus input': (evt) ->
    Session.set('item_id', this._id)

Template.view_potluck.events[okcancel_events('.person')] =
  make_okcancel_handler
    ok: (text, evt) ->
      Items.update(Session.get('item_id'),$set: {name: text})
      Session.set('item_id',null)
    cancel: (evt) ->
      Session.set('item_id',null)
      evt.target.value = ""

Template.view_potluck.events[okcancel_events('.details')] =
  make_okcancel_handler
    ok: (text, evt) ->
      Items.update(Session.get('item_id'),$set: {details: text})
      Session.set('item_id',null)
    cancel: (evt) ->
      Session.set('item_id',null)
      evt.target.value = ""

Template.view_potluck.events[okcancel_events('#new-name')] =
  make_okcancel_handler
    ok: (text, evt) ->
      pattern = /(\d+)/g
      count = text.match(pattern)
      times = (count && count[0]) || 1
      for i in [1..times]  
        item =
          title: get_name(text)
          pid: Session.get('id')
          name: ''
          email: ''
        Items.insert(item)
      evt.target.value = ""
