local speed = 2

local startCoord = {0, 0, 0}
local lastCoord = {0, 0, 0}
local time = 0
local redVoxel = {
  color = {255, 0, 0},
  layer = Cosm.LayerType.Solid
}

function start()
  startCoord = Cosm.cursor.coord
end

function update()
  time = time + (Cosm.time.deltaTime * speed)

  local sin = math.sin(time) * 5
  local cos = math.cos(time) * 5

  local y = startCoord[2] + sin
  local x = startCoord[1] + cos
  local z = startCoord[3]

  Cosm.currentWorld:drawVoxel(
    lastCoord,
    nil,
    Cosm.DrawMode.Delete
  )

  lastCoord = {x, y, z}

  Cosm.currentWorld:drawVoxel(
    lastCoord,
    redVoxel,
    Cosm.DrawMode.Set
  )
end
