Paddle = {}

local paddleVoxel = {
  color = {60, 64, 72},
  layer = Cosm.LayerType.Solid
}

function Paddle:Create(
  game,
  startCoord
)
  paddle = {}

  setmetatable(paddle, self)
  self.__index = self

  paddle.width = 5
  paddle.height = 1
  paddle.x = startCoord[1] - math.floor(paddle.width / 2)
  paddle.y = startCoord[2]
  paddle.z = startCoord[3]
  paddle.intX = startCoord[1]
  paddle.lastIntX = 0
  paddle.velX = 0
  paddle.minX = game.arena.minX + 1
  paddle.maxX = game.arena.maxX

  return paddle
end

function Paddle:BaseUpdate()
  self:_updatePosition()
  self:_collideWalls()

  self.intX = math.floor(self.x)

  local positionChanged = self.intX != self.lastIntX

  if positionChanged then
    self:_clear()
    self:_draw()
  end

  self.lastIntX = self.intX
end

function Paddle:_getStart(startX)
  return {
    startX,
    self.y,
    self.z,
  }
end

function Paddle:_getEnd(startX)
  return {
    startX + self.width - 1,
    self.y,
    self.z,
  }
end

function Paddle:_clear()
  Cosm.currentWorld:drawLine(
    self:_getStart(self.lastIntX),
    self:_getEnd(self.lastIntX),
    nil,
    Cosm.DrawMode.Set
  )
end

function Paddle:_updatePosition()
  self.x = self.x + self.velX * Cosm.time.deltaTime
end

function Paddle:_collideWalls()
  if self.x < self.minX then
    self.x = self.minX
    self.velX = 0 -- zero velocity to prevent imparting wrong velocity to ball
  elseif self.x + self.width >= self.maxX then
    self.x = self.maxX - self.width
    self.velX = 0 -- zero velocity to prevent imparting wrong velocity to ball
  end
end

function Paddle:_draw()
  Cosm.currentWorld:drawLine(
    self:_getStart(self.intX),
    self:_getEnd(self.intX),
    paddleVoxel,
    Cosm.DrawMode.Set
  )
end
