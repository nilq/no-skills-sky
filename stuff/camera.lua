Camera = {}

function Camera:make()

  local camera = {
    x = 0,
    y = 0,
    sx = 1,
    sy = 1,
    r = 0,
  }

  function camera:set()
    love.graphics.push()
    love.graphics.translate(self:get_width()*2, self:get_height()*2)
    love.graphics.rotate(-self.r)
    love.graphics.translate(-self:get_width()*2, -self:get_height()*2)
    love.graphics.scale(1 / self.sx, 1 / self.sy)
    love.graphics.translate(-self.x, -self.y)
  end

  function camera:unset()
    love.graphics.pop()
  end

  function camera:get_width()
    return love.graphics.getWidth() * self.sx
  end

  function camera:get_height()
    return love.graphics.getHeight() * self.sy
  end

  function camera:get_dimension()
    return self:get_width(), self:get_height()
  end

  return camera
end

return Camera
