require "nybbleNumbers"
require "nybbleWords"

Scoreboard = {}

local scoreboardVoxel = {
  color = {177, 177, 178},
  layer = Cosm.LayerType.Solid,
}

local nilVoxel = nil

local textPalette = {nilVoxel, scoreboardVoxel}

local scoreboardYPadding = 4

local winningScore = 6

function Scoreboard:Create(startCoord, gameHeight)
  scoreboard = {}

  setmetatable(scoreboard, self)
  self.__index = self

  scoreboard.startCoord = startCoord
  scoreboard.minX = startCoord[1] - math.floor(nybbleNumbers.width / 2)
  scoreboard.z = startCoord[3] + 2
  scoreboard.playerScore = 0
  scoreboard.computerScore = 0

  scoreboard.maxYComputerScore = startCoord[2] + gameHeight - 1 - scoreboardYPadding
  scoreboard.maxYPlayerScore = startCoord[2] + scoreboardYPadding + nybbleNumbers.height - 1

  return scoreboard
end

function Scoreboard:DrawInitialScores()
  self:_drawPlayerScore()
  self:_drawComputerScore()
end

function Scoreboard:IncrementPlayerScore()
  self.playerScore = self.playerScore + 1
  self:_drawPlayerScore()

  if self.playerScore == winningScore then
    self:_endGame()
  else
    self:_drawPlayerScore()
  end
end

function Scoreboard:IncrementComputerScore()
  self.computerScore = self.computerScore + 1

  if self.computerScore == winningScore then
    self:_endGame()
  else
    self:_drawComputerScore()
  end
end

function Scoreboard:_drawPlayerScore()
  nybbleNumbers.drawNumber(
    self.playerScore,
    textPalette,
    {self.minX, self.maxYPlayerScore, self.z}
  )
end

function Scoreboard:_drawComputerScore()
  nybbleNumbers.drawNumber(
    self.computerScore,
    textPalette,
    {self.minX, self.maxYComputerScore, self.z}
  )
end

function Scoreboard:_endGame()
  local playerWon = self.playerScore > self.computerScore
  local playerLost = self.playerScore < self.computerScore

  self:_drawWin(playerWon)
  self:_drawLose(playerLost)

  complete()
end

function Scoreboard:_drawWin(playerWon)
  local y = playerWon and self.maxYPlayerScore or self.maxYComputerScore

  nybbleWords.drawWord(
    "win",
    textPalette,
    {
      self.startCoord[1] - math.floor(nybbleWords.winWidth / 2),
      y,
      self.z
    }
  )
end

function Scoreboard:_drawLose(playerLost)
  local y = playerLost and self.maxYPlayerScore or self.maxYComputerScore

  nybbleWords.drawWord(
    "lose",
    textPalette,
    {
      self.startCoord[1] - math.floor(nybbleWords.loseWidth / 2),
      y,
      self.z
    }
  )
end
