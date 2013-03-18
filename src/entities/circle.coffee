# Basic circle shape for drawing
class D.Circle extends D.Entity
  # Circle radius
  radius: null

  # Circle collision detection
  hitTest: (position) ->
    r = @radius
    r *= r

    dx = @x - position.x
    dy = @y - position.y

    C.info((dx * dx) + (dy + dy))

    if (r > (dx * dx) + (dy + dy))
      true
    else
      false

  # Basic circle drawing code, override for customization
  render: (game) ->
    # Get inner canvas context
    ctx = game.bufferContext
    # Draw the ball
    ctx.strokeStyle = '#fff'
    ctx.lineWidth = 3
    ctx.fillStyle = @color
    ctx.beginPath()
    ctx.arc(@x, @y, @radius, 0, Math.PI * 2, true)
    ctx.fill()
    ctx.stroke()
