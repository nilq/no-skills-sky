local Thruster = {}

function Thruster:make(x, y)
  local thruster = {
    x = x, y = y,
    acc = 0,    active = true,
    boost = 5,  boost  = false,
  }

  function thruster:update(frc, dt)
    self.acc = self.acc - (self.acc / frc) * dt
  end

  function thruster:get_normal(x, y)
    local a = math.atan2(y - self.y, x - self.x)
    return math.cos(a), math.sin(a)
  end

  function thruster:toggle()
    self.acc = 0
    self.active = not self.active
  end

  function thruster:draw()
    if self.active then
      love.graphics.setColor(0, 0, 150)
      love.graphics.circle("fill", self.x, self.y, 7)

      love.graphics.setColor(0, 0, 100)
      love.graphics.circle("line", self.x, self.y, 7)
    else
      love.graphics.setColor(150, 0, 0)
      love.graphics.circle("fill", self.x, self.y, 7)

      love.graphics.setColor(100, 0, 0)
      love.graphics.circle("line", self.x, self.y, 7)
    end
  end

  return thruster
end

return Thruster
