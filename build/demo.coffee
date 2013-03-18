#
# Vision of how Diesel works
#

# Initialize engine from singleton
game = D.Game.get
  title: "Chain Reaction Game v1.0"
  container: document.querySelector('#game')


# Sample ball entity which moves around
# Also responds to click to change color
class Ball extends D.Circle
  init: () ->
    # Store width, height, x and y
    super(30, 30, 30, 30)

    # Out entity can move, so we specify acceleration
    @dx = 1.5
    @dy = 2.5

    # Our entity is a circle, so we store the radius
    @radius = 30

    # Our circle is red to begin with
    @color = '#ff0000'

    @

  # Update ball coordinates on each frame
  update: (game) ->
    # Game screen size
    _gw = game.width
    _gh = game.height

    # Bounce back horizontally
    if (@x + @dx + @radius) > _gw || (@x + @dx - @radius ) < 0
      @dx = -@dx

    # Bounce back vertically
    if (@y + @dy + @radius) > _gh || (@y + @dy - @radius ) < 0
      @dy = -@dy

    # Set new position
    @x += @dx
    @y += @dy

  # Events
  handleClick: (eventData, game) ->
    # Check collision
    if @color is '#ff0000'
      @color = '#00ff00'
    else
      @color = '#ff0000'


class DemoState extends D.GameState
  init: () ->
    100.times =>
      ball = new Ball()
      ball.init()
      ball.radius = 20
      ball.x = D.Util.randomInt(ball.radius, 600-ball.radius)
      ball.y = D.Util.randomInt(ball.radius, 400-ball.radius)
      dirX = if D.Util.randomInt(0, 1) is 1 then 1 else -1
      dirY = if D.Util.randomInt(0, 1) is 1 then 1 else -1
      ball.dx = (D.Util.randomInt(5, 20) / 10.0) * dirX
      ball.dy = (D.Util.randomInt(5, 20) / 10.0) * dirY
      ball.color = D.Color.randomHexString()
      @entities.push(ball)

  update: (game) ->
    super(game)

  render: (game) ->
    super(game)
    ctx = game.bufferContext
    ctx.fillStyle = '#fff'
    ctx.font = '14px Verdana'
    ctx.fillText game.fps.toFixed(0), 10, 20

# Set up intro state
game.changeState(DemoState.get())

game.run()
