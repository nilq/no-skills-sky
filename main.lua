love.graphics.setDefaultFilter("nearest", "nearest")
love.graphics.setBackgroundColor(255, 255, 255)

cam_x, cam_y = 0, 0

function math.lerp(a, b, t)
  return (1 - t) * a + t * b
end

function math.clamp(a, b, n)
  if n < a then
    return a
  elseif n > b then
    return b
  end
  return n
end

function love.load()

  local Player = require "stuff/player"

  player = Player:make(400, 300)
  player:load()
end

function love.update(dt)
  player:update(dt)

  cam_x = math.lerp(cam_x, -player.r.x + love.graphics.getWidth() / 2, 10 * dt)
  cam_y = math.lerp(cam_y, -player.r.y + love.graphics.getHeight() / 2, 10 * dt)
end

function love.draw()
  love.graphics.push()
  love.graphics.translate(cam_x, cam_y)

  love.graphics.setColor(0, 0, 0, 122)

  for i = 1, love.graphics.getWidth(), 48 do
    love.graphics.line(cam_x + i, -cam_y, i, love.graphics.getHeight() - cam_y)
  end

  for i = 1, love.graphics.getHeight(), 48 do
    love.graphics.line(-cam_x, cam_y + i, love.graphics.getWidth() - cam_x, i)
  end

  player:draw()

  love.graphics.pop()
end

function love.keypressed(key, scancode, isrepeat)
  player:press(key)
end
