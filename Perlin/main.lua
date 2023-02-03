local width = 32
local height = 32
local scale = 3

function start()
  local startCoord = Cosm.cursor.coord

  for x = 1, width do
    for z = 1, height do
      local noiseX = x / width * scale
      local noiseZ = z / height * scale

      local brightness = Cosm.math:perlinNoise(noiseX, noiseZ) * 255

      Cosm.currentWorld:drawVoxel(
        {
          startCoord[1] - 1 + x,
          startCoord[2],
          startCoord[3] - 1 + z,
        },
        {
          color = {brightness, brightness, brightness},
          layer = Cosm.LayerType.Solid
        },
        Cosm.DrawMode.Set
      )
    end
  end
end
