local hue = 0
local saturation = 80
local value = 80

local startCoord = {0, 0, 0}

function start()
  startCoord = Cosm.cursor.coord
end

function update()
  hue = (hue + 1) % 360

  Cosm.currentWorld:drawVoxel(
    startCoord,
    {
      color = Cosm.color:hsvToRgb(hue, saturation, value),
      layer = Cosm.LayerType.Solid
    },
    Cosm.DrawMode.Set
  )
end
