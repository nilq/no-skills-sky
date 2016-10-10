local Rocket = {}

function Rocket:make(x, y)
  local rocket = {
    x = x, y = y,
    r = 0, rad = 15,
    dx = 0, dy = 0,
    frc = 4.25,
    --
    thrusters = {},
    angles = {},
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
    for i = 1, #self.thrusters do
      local t = self.thrusters[i]
      if t.active then
        local dx, dy = t:get_normal(self.x, self.y)

        love.graphics.setColor(255, 0, 0)
        love.graphics.line(t.x + dx, t.y + dy, t.x + dx * t.acc * 50, t.y + dy * t.acc * 50)
      end
      t:draw()
    end

    love.graphics.setColor(150, 150, 150)
    love.graphics.circle("fill", self.x, self.y, self.rad)

    love.graphics.setColor(100, 100, 100)
    love.graphics.circle("line", self.x, self.y, self.rad)

    love.graphics.setColor(0, 255, 0)
    love.graphics.line(self.x + self.dx, self.y + self.dy, self.x + self.dx * 50, self.y + self.dy * 50)
  end

  return rocket
end

return Rocket
