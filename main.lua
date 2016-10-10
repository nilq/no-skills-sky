love.graphics.setDefaultFilter("nearest", "nearest")
love.graphics.setBackgroundColor(255, 255, 255)

function math.lerp(a, b, t)
  return (1 - t) * a + t * b
end

function love.load()
  local Player = require "stuff/player"

  player = Player:make(400, 300)
  player:load()
end

function love.update(dt)
  player:update(dt)
end

function love.draw()
  player:draw()
end

function love.keypressed(key, scancode, isrepeat)
  player:press(key)
end
