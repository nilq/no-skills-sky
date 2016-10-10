local Player = {}

function Player:make(x, y)
  local player = {
    acc = 10,
  }

  function player:load()
    local Rocket = require "stuff/rocket"
    local Bullet = require "stuff/bullet"

    self.r = Rocket:make(x, y)
    self.r:load()

    self.bullet = Bullet:make()
  end

  function player:update(dt)

    if love.keyboard.isDown("d") then
      local ts = self.r.thrusters
      ts[1].acc = ts[1].acc - 0.15
      ts[2].acc = ts[2].acc + 0.15
    end

    if love.keyboard.isDown("a") then
      local ts = self.r.thrusters
      ts[1].acc = ts[1].acc + 0.15
      ts[2].acc = ts[2].acc - 0.15
    end

    if love.keyboard.isDown("w") then
      for i = 1, #self.r.thrusters do
        local t = self.r.thrusters[i]
        t.acc = t.acc + self.acc * dt
      end
    end

    if love.keyboard.isDown("s") then
      for i = 1, #self.r.thrusters do
        local t = self.r.thrusters[i]
        t.acc = math.lerp(t.acc, 0, dt * 2)
      end
    end

    for i = 1, #self.r.thrusters do
      self.r.thrusters[i].acc = math.clamp(-19, 19, self.r.thrusters[i].acc)
    end

    self.r:update(dt)
    self.bullet:update(dt)
  end

  function player:draw()
    self.r:draw()
    self.bullet:draw()
  end

  function player:press(key)
    if key == "space" then
      bullet:make_rotation(self.r.x, self.r.y, self.r.r, -1000)
    end
  end

  return player
end

return Player
