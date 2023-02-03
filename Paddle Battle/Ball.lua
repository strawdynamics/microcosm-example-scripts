require "util"

Ball = {}
Ball.__index = Ball

local ballVoxel = {
  color = {1, 171, 179},
  layer = Cosm.LayerType.Solid
}

local ballMaxVelX = 24
local impartPaddleVelocityCoefficient = 0.2

function Ball.Create(
  game,
  startCoord,
  onGoalScored,
  computerPaddle,
  playerPaddle,
)
  local ball = {}

  setmetatable(ball, Ball)
  ball.game = game
  ball.computerPaddle = computerPaddle
  ball.playerPaddle = playerPaddle
  ball.minX = game.arena.minX + 1
  ball.maxX = game.arena.maxX - 1
  ball.minY = game.arena.minY + 1
  ball.maxY = game.arena.maxY - 1
  ball.x = startCoord[1]
  ball.y = startCoord[2]
  ball.z = startCoord[3]
  ball.intX = startCoord[1]
  ball.intY = startCoord[2]
  ball.lastIntX = 0
  ball.lastIntY = 0
  ball.onGoalScored = onGoalScored
  ball.velX = math.random(-20, 20)
  ball.velY = math.random(8, 12)
  ball.width = 1 -- Only set up for 1x1, this is just used for collision
  ball.height = 1 -- Only set up for 1x1, this is just used for collision

  return ball
end

function Ball:Update()
  self:_updatePosition()

  if self:_collideGoals() then
    return
  end
  self:_collideWalls()
  self:_collidePaddles()

  self.intX = util.round(self.x)
  self.intY = util.round(self.y)

  local positionChanged = self.intX != self.lastIntX or self.intY != self.lastintY

  if positionChanged then
    self:_clear()
    self:_draw()
  end

  self.lastIntX = self.intX
  self.lastIntY = self.intY
end

function Ball:Destroy()
  self:_clear()
end

function Ball:_clear()
  local lastPos = {self.lastIntX, self.lastIntY, self.z}
  Cosm.currentWorld:drawVoxel(lastPos, nil, Cosm.DrawMode.Set)
end

function Ball:_updatePosition()
  self.x = self.x + self.velX * Cosm.time.deltaTime
  self.y = self.y + self.velY * Cosm.time.deltaTime
end

function Ball:_collideWalls()
  if self.x < self.minX then
    self.x = self.minX
    self.velX = self.velX * -1
  elseif self.x > self.maxX then
    self.x = self.maxX
    self.velX = self.velX * -1
  end
end

function Ball:_collideGoals()
  -- FIXME: using . and manually passing Game instance because otherwise `self`
  -- is incorrect in Game. Not sure how to idiomatically deal with this in Lua.
  if self.y > self.maxY then
    self.onGoalScored(self.game, 'top')
    return true
  elseif self.y < self.minY then
    self.onGoalScored(self.game, 'bottom')
    return true
  end

  return false
end

function Ball:_collidePaddles()
  if util.collides(self, self.computerPaddle) then
    self.velY = self.velY * -1
    -- move ball to prevent colliding again next frame
    self.y = self.computerPaddle.y - self.height
  elseif util.collides(self, self.playerPaddle) then
    self.velY = self.velY * -1
    -- move ball to prevent colliding again next frame
    self.y = self.playerPaddle.y + self.playerPaddle.height

    self:_impartPaddleVelocity(self.playerPaddle.velX)
  end
end

function Ball:_impartPaddleVelocity(paddleVelocity)
  self.velX  = math.max(
    -ballMaxVelX,
    math.min(self.velX + (paddleVelocity * impartPaddleVelocityCoefficient), ballMaxVelX)
  )
end

function Ball:_draw()
  Cosm.currentWorld:drawVoxel(
    {self.intX, self.intY, self.z},
    ballVoxel,
    Cosm.DrawMode.Set
  )
end
