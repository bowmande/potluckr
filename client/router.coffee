PotluckRouter = Backbone.Router.extend
  routes:
    "": "index"
    "new": "new"
    ":id": "main"
    ":id/edit": "edit"
  index: ->
  new: ->
    potluck = Potlucks.insert({ts: (new Date()).getTime()})
    console.log "Created", potluck
    this.navigate("#{potluck}/edit")
  main: (id) ->
    Session.set("id",id)
  edit: (id) ->
    Session.set("editing_id",id)

Router = new PotluckRouter

Meteor.startup ->
  Backbone.history.start({pushState: true})