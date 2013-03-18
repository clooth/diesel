# Game state
class D.GameState
  instance = null

  @get: () ->
    instance ?= new @

  # Entities in this state
  entities: []

  # Do initialization for the game state here
  init: () ->
    console.log('Game state init')

  # Clean up any assets and stuff you don't need anymore
  cleanup: () ->

  # Pause game state, stop needed stuff here
  pause: () ->

  # Resume game state, restart whatever here
  resume: () ->

  # Handle all events this state uses in here
  handleEvent: (event, game) ->
    # Mouse click event
    if event.type is 'click'
      # State checks entities valid for event
      for entity in @entities
        # Check mouse click coordinates
        clickPos = new Vector(event.clientX, event.clientY)
        if entity.hitTest(clickPos, game)
          entity.handleEvent(event.type, event, game)

  # Update variables of the state on each tick
  update: (game) ->
    entity.update(game) for entity in @entities
    return

  # Clear state
  clear: (game) ->
    entity.clear(game) for entity in @entities
    return

  # Re-render this game state
  render: (game) ->
    entity.render(game) for entity in @entities
    return

  # Change the state from the current state
  changeState: (game, state) ->
    game.changeState(state)
