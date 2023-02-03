require "Paddle"
require "util"

local computerPaddleVel = 10

ComputerPaddle = {}

function ComputerPaddle.Create(
  game,
  startCoord,
)
  computerPaddle = Paddle:Create(game, startCoord)

  function computerPaddle:Update()
    self:_updateVelocity()
    self:BaseUpdate()
  end

  function computerPaddle:_updateVelocity()
    if self.ball ~= nil then
      local halfWidth = self.width / 2
      local maxLeft = self.x + math.floor(halfWidth)
      local minRight = self.x + math.ceil(halfWidth)

      if self.ball.x < maxLeft then
        self.velX = -computerPaddleVel
      elseif self.ball.x > minRight then
        self.velX = computerPaddleVel
      else
        self.velX = 0
      end
    end
  end

  return computerPaddle
end
