# Main game engine class
# Acts as singleton, so only one instance can be created at a time
# To create/get engine instance, use GameEngine.get("Game name")
class D.Game
  instance = null

  # Private engine class which the singleton uses internally
  class PrivateGame
    # Debug mode
    debug: true
    # The stack of game states
    states: []
    # Game canvas container
    container: null
    # Game canvas
    canvas: null
    # Game canvas context
    context: null
    # Buffer
    bufferCanvas: null
    bufferContext: null
    # Game dimensions
    width: null
    height: null

    constructor: (params) ->
      # Set game title
      @title = params.title or "Untitled Diesel Game"

      # Save container info
      # TODO: Better fallback / compatibility
      @container = params.container or document.querySelector('body')

      # Initialize game screen stuff
      @init()

      # Initialize event handlers
      @bindEvents()

      # Debug logging
      console.log("DGame initialized.")

    # Initialize game engine stuff
    init: () ->
      # Set up the canvas
      @canvas = document.createElement 'canvas'
      @context = @canvas.getContext '2d'

      # Get parent width and height for proper dimensions
      @width = @container.clientWidth
      @height = @container.clientHeight

      # Set canvas dimensions correctly
      @canvas.width = @width
      @canvas.height = @height

      # Create buffer for faster drawing
      @bufferCanvas = document.createElement 'canvas'
      @bufferCanvas.width = @width
      @bufferCanvas.height = @height
      @bufferContext = @bufferCanvas.getContext '2d'

      # Display
      @container.appendChild(@canvas)

    # Bind supported events
    # TODO: Separate into diesel_input.coffee
    bindEvents: () ->
      # Bind all events to canvas
      events = ['click']
      for ev in events
        @canvas.addEventListener ev, @handleEvent.bind(this)

    handleEvent: (e) ->
      # Handler delegates to current state
      @states.last().handleEvent(e, @)

    # Change game state
    changeState: (state) ->
      # Clean up current state, if any
      if (@states.length > 0)
        @states.last().cleanup()
        @states.pop()

      # Store and init the new state
      @states.push(state)
      @states.last().init()

    # Push new state
    pushState: (state) ->
      # Pause current state
      if (@states.length > 0)
        @states.last().pause()

      # Store and init the new state
      @states.push(state)
      @states.last().init()

    # Pop last state from engine
    popState: () ->
      # Clean up current state
      if (@states.length > 0)
        @states.last().cleanup()
        @states.pop()

      # Resume previous state
      if (@states.length > 0)
        @states.last().resume()

    # Handle state updates
    update: () ->
      @states.last().update(this)

    handleEvents: () ->
      @states.last().handleEvents(this)

    clear: () ->
      @bufferCanvas.width = @bufferCanvas.width
      @canvas.width = @canvas.width
      @states.last().clear(this)

    # Handle state renders
    render: () ->
      if (!@lastRun)
        @lastRun = new Date().getTime()
        requestAnimationFrame(@render.bind(@))
        return

      delta = (new Date().getTime() - @lastRun)/1000
      @lastRun = new Date().getTime()
      @fps = 1/delta

      requestAnimationFrame(@render.bind(@))

      @update()
      @clear()
      @states.last().render(this)
      @context.drawImage(@bufferCanvas, 0, 0)

    # Run game
    run: () ->
      @render()

  # Create or access singleton game engine class
  @get: (params) ->
    instance ?= new PrivateGame(params)
