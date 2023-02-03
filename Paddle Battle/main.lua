require "Game"

local width = 31
local height = 29

s = {}

function start()
  local startCoord = Cosm.cursor.coord
  s.game = Game.Create(startCoord, width, height)
  s.game:Begin()
end

function update()
  s.game:Update()
end
