local Rocket = {}

function Rocket:make(x, y)
  local rocket = {
    x = x, y = y,
    r = 0, rad = 15,
    dx = 0, dy = 0,
    frc = 0.925,
    --
    thrusters = {},
    angles = {},
    --
    sprite = love.graphics.newImage("res/ship.png"),
  }

  function rocket:load()
    local Thruster = require "stuff/thruster"

    self.angles = {
      [1] = {
        x = -math.pi / 4,
        y = -math.pi / 4,
      },
      [2] = {
        x = math.pi / 4,
        y = math.pi / 4
      },
    }

    for i = 1, #self.angles do
      local a = self.angles[i]

      self.thrusters[#self.thrusters + 1] = Thruster:make(self.x + math.cos(self.r + a.x) * self.rad, self.y + math.sin(self.r + a.y) * self.rad)
    end
  end

  function rocket:update(dt)

    local dx, dy = 0, 0
    local drx, dry = 0, 0
    for i = 1, #self.thrusters do
      local t = self.thrusters[i]
      if t.active then
        local ddx, ddy = t:get_normal(self.x, self.y)

        drx = drx + ddx
        dry = dry + ddy

        dx, dy = dx + ddx * t.acc, dy + ddy * t.acc
      end

      t:update(self.frc, dt)
    end

    self.dx = self.dx + dx * dt
    self.dy = self.dy + dy * dt

    self.dx = self.dx - (self.dx / self.frc) * dt
    self.dy = self.dy - (self.dy / self.frc) * dt

    self.x  = self.x + self.dx
    self.y  = self.y + self.dy

    -- really bad hack: kil mi 5 dis plz
    local t1 = self.thrusters[1]
    local t2 = self.thrusters[2]
    self.r = math.atan2((t1.y + t2.y)/2 - self.y, (t1.x + t2.x)/2 - self.x)
    -- end of shit hack

    for i = 1, #self.angles do
      local a = self.angles[i]

      self.thrusters[i].x = self.x + math.cos(self.r + a.x) * self.rad
      self.thrusters[i].y = self.y + math.sin(self.r + a.y) * self.rad
    end

  end

  function rocket:draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(self.sprite, self.x, self.y, self.r + math.pi / 2, 0.75, 0.75, self.sprite:getWidth() / 2, self.sprite:getHeight() / 2)
  end

  return rocket
end

return Rocket
