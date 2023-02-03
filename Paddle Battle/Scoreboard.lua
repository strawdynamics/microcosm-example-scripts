require "nybbleNumbers"

Scoreboard = {}

local scoreboardVoxel = {
  color = {177, 177, 178},
  layer = Cosm.LayerType.Solid,
}

local nilVoxel = nil

local textPalette = {nilVoxel, scoreboardVoxel}

local scoreboardYPadding = 4

function Scoreboard:Create(startCoord, gameHeight)
  scoreboard = {}

  setmetatable(scoreboard, self)
  self.__index = self

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
end

function Scoreboard:_drawPlayerScore()
  nybbleNumbers.drawNumber(
    self.playerScore,
    textPalette,
    {self.minX, self.maxYPlayerScore, self.z}
  )
end

function Scoreboard:IncrementComputerScore()
  self.computerScore = self.computerScore + 1
  self:_drawComputerScore()
end

function Scoreboard:_drawComputerScore()
  nybbleNumbers.drawNumber(
    self.computerScore,
    textPalette,
    {self.minX, self.maxYComputerScore, self.z}
  )
end
