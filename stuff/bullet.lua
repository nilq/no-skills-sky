Bullet = {}

function Bullet:make()

  bullet = {}
  bullets = {}

  bullet.missile = love.graphics.newImage("res/missile.png");

  function bullet:make (x, y, dx, dy)
    local r = math.atan2(dy, dx)
    table.insert(bullets ,{x=x, y=y, dx=dx, dy=dy, r=r})
  end

  function bullet:make_rotation (x, y, r, s)
    local dx, dy = s*math.cos(r), s*math.sin(r)
    table.insert(bullets ,{x=x, y=y, dx=dx, dy=dy, r=r})
  end

  function bullet:update (dt, targets)
    for i, v in ipairs(bullets) do
      print(v.dx, v.dy)
      v.x = v.x + v.dx*dt
      v.y = v.y + v.dy*dt
    end
  end

  function bullet:draw ()
    for i, v in ipairs(bullets) do
      love.graphics.draw(self.missile, v.x, v.y, v.r-math.pi/2)
    end
  end

  return bullet

end

return Bullet
