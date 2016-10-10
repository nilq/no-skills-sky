love.graphics.setBackgroundColor(255, 255, 255)

cam_x, cam_y = 0, 0
tile_scale = 32

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
  local Camera = require "stuff/camera"
  camera = Camera:make()

  player = Player:make(400, 300)
  player:load()
end

function love.update(dt)
  player:update(dt)

  camera.x = math.lerp(camera.x, player.r.x - camera:get_width() / 2, 10 * dt)
  camera.y = math.lerp(camera.y, player.r.y - camera:get_height() / 2, 10 * dt)
  print(camera.x, camera.y)
end

function love.draw()
  camera:set()

  love.graphics.setColor(0, 0, 0)
  --vertcal lines
  for i=camera.x-camera.x%32, camera:get_width()+camera.x, tile_scale do
    love.graphics.line(i, camera.y, i, camera:get_height()+camera.y)
  end

  --horizontal lines
  for i=camera.y-camera.y%32, camera:get_height()+camera.y, tile_scale do
    love.graphics.line(camera.x, i, camera:get_width()+camera.x, i)
  end

  player:draw()

  camera:unset()
end

function love.keypressed(key, scancode, isrepeat)
  player:press(key)
end
