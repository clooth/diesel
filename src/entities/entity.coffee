class D.Entity extends Observer
  # Entity dimensions
  width: null
  height: null

  # Entity coordinates
  x: null
  y: null

  # Event listeners
  events: {}

  init: (@width, @height, @x, @y) ->

  update: (game) ->

  clear: (game) ->

  render: (game) ->

  # Bind an event to entity
  bindEvent: (type, handler) ->
    # We support multiple handlers per event,
    # so check for existing.
    if events[type].length is 0
      events[type] = []
    events[type].push(handler)

  # Responds to event?
  respondsTo: (eventType) ->
    eventHandler = "handle#{eventType.capitalize()}"
    if @[eventHandler]?
      return true
    false

  # Handle event
  handleEvent: (eventType, eventData, game) ->
    if @respondsTo(eventType) is true
      eventHandler = "handle#{eventType.capitalize()}"
      @[eventHandler](eventData, game)