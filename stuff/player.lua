local Player = {}

function Player:make(x, y)
  local player = {
    acc = 10,
  }

  function player:load()
    local Rocket = require "stuff/rocket"

    self.r = Rocket:make(x, y)
    self.r:load()
  end

  function player:update(dt)

    if love.keyboard.isDown("t") then
      for i = 1, #self.r.thrusters do
        local t = self.r.thrusters[i]
        t.acc = t.acc + self.acc * dt
      end
    end

    if love.keyboard.isDown("q") then
      for i = 1, #self.r.thrusters do
        local t = self.r.thrusters[i]
        t.acc = t.acc - self.acc * dt
      end
    end

    self.r:update(dt)
  end

  function player:draw()
    self.r:draw()
  end

  function player:press(key)
    if key == "v" then
      self.r.thrusters[1].active = not self.r.thrusters[1].active
    end
    if key == "x" then
      self.r.thrusters[2].active = not self.r.thrusters[1].active
    end
  end

  return player
end

return Player
