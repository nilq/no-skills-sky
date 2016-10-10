local Thruster = {}

function Thruster:make(x, y)
  local thruster = {
    x = x, y = y,
    acc = 1000,
  }

  function thruster:get_normal(x, y)
    local a = math.atan2(y - self.y, x - self.x)
    return math.cos(a), math.sin(a)
  end

  function thruster:draw()
    love.graphics.setColor(150, 0, 0)
    love.graphics.circle("fill", self.x, self.y, 7)

    love.graphics.setColor(100, 0, 0)
    love.graphics.circle("line", self.x, self.y, 7)
  end

  return thruster
end

return Thruster
