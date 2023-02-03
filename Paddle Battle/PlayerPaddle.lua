require "Paddle"
require "util"

local playerPaddleAccel = 160
local playerPaddleMaxVel = 25

PlayerPaddle = {}

function PlayerPaddle.Create(
  game,
  startCoord,
)
  playerPaddle = Paddle:Create(game, startCoord)

  function playerPaddle:Update()
    self:_updateVelocity()
    self:BaseUpdate()
  end

  function playerPaddle:_updateVelocity()
    local target = Cosm.cursor.coord[1] + 0.5
    local halfWidth = self.width / 2
    local maxLeft = self.x + math.floor(halfWidth)
    local minRight = self.x + math.ceil(halfWidth)

    local targetVel = 0

    if target < maxLeft then
      targetVel = -playerPaddleMaxVel
    elseif target > minRight then
      targetVel = playerPaddleMaxVel
    end

    if self.velX > targetVel then
      self.velX = self.velX - playerPaddleAccel * Cosm.time.deltaTime
    elseif self.velX < targetVel then
      self.velX = self.velX + playerPaddleAccel * Cosm.time.deltaTime
    end
  end

  return playerPaddle
end
