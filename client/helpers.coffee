okcancel_events = (selector) ->
  'keyup '+selector+', keydown '+selector+', focusout '+selector
make_okcancel_handler = (options) ->
  ok = options.ok || -> {}
  cancel = options.cancel || -> {}
  
  (evt) ->
    if evt.type == 'keydown' && evt.which == 27
      cancel.call(this, evt)
    else if evt.type == "keyup" && evt.which == 13
      value = String(evt.target.value || "")
      if value
        ok.call(this, value, evt)
      else
        cancel