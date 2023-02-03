require "Arena"
require "Ball"
require "ComputerPaddle"
require "PlayerPaddle"
require "Scoreboard"

Game = {}
Game.__index = Game

-- https://gist.github.com/straker/81b59eecf70da93af396f963596dfdc5
function Game.Create(startCoord, width, height)
  local game = {}

  setmetatable(game, Game)
  game.startCoord = startCoord
  game.centerCoord = {
    startCoord[1],
    startCoord[2] + math.floor(height / 2),
    startCoord[3]
  }
  game.width = width
  game.height = height
  game.arena = Arena.Create(startCoord, width, height)
  game.scoreboard = Scoreboard:Create(startCoord, height)

  return game
end

function Game:Begin()
  self.arena:Draw()
  self.scoreboard:DrawInitialScores()

  self:SpawnPaddles()
  self:SpawnBall()
end

function Game:Update()
  self.playerPaddle:Update()
  self.computerPaddle:Update()

  if self.ball != nil then
    self.ball:Update()
  end
end

function Game:_handleGoalScored(whichGoal)
  if whichGoal == 'top' then
    scoreboard:IncrementPlayerScore()
  else
    scoreboard:IncrementComputerScore()
  end

  self.ball:Destroy()
  self.ball = nil
  self:SpawnBall()
end

function Game:SpawnPaddles()
  local compPaddleStart = {
    self.centerCoord[1],
    self.startCoord[2] + self.height - 2,
    self.startCoord[3],
  }
  self.computerPaddle = ComputerPaddle.Create(self, compPaddleStart)

  local playerPaddleStart = {
    self.centerCoord[1],
    self.startCoord[2] + 1,
    self.startCoord[3],
  }

  self.playerPaddle = PlayerPaddle.Create(self, playerPaddleStart)
end

function Game:SpawnBall()
  self.ball = Ball.Create(
    self,
    self.centerCoord,
    self._handleGoalScored,
    self.computerPaddle,
    self.playerPaddle
  )

  self.computerPaddle.ball = self.ball
end
