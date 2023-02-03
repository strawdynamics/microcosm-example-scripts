local noise = require("noise")
local terrainTypes = require("terrainTypes")

local mapWidth = 64
local mapHeight = 64
local seed = 4242
local noiseScale = 60
local octaves = 4
local persistence = 0.5
local lacunarity = 2

local heightScale = 48
local seaLevel = heightScale * 0.4

function start()
  local curCoord = Cosm.cursor.coord
  local chunkX = math.floor(curCoord[1] / mapWidth)
  local chunkZ = math.floor(curCoord[3] / mapHeight)
  local startCoord = {
    chunkX * mapWidth,
    0,
    chunkZ * mapHeight,
  }

  Cosm.currentWorld:drawBox(
    {
      startCoord[1],
      startCoord[2] - 1,
      startCoord[3],
    },
    {
      startCoord[1] + mapWidth - 1,
      startCoord[2] - 1,
      startCoord[3] + mapHeight - 1,
    },
    {
      color = {42, 42, 42},
      layer = Cosm.LayerType.Solid
    },
    Cosm.DrawMode.Set
  )

  DrawMap(startCoord, mapWidth, mapHeight)
end

function DrawMap(startCoord, mapWidth, mapHeight)
  local offset = {startCoord[1], startCoord[3]}
  local noiseMap = noise.generateNoiseMap(
    mapWidth,
    mapHeight,
    seed,
    noiseScale,
    octaves,
    persistence,
    lacunarity,
    offset
  )

  for x, perlinValues in ipairs(noiseMap) do
    for y, perlinValue in ipairs(perlinValues) do
      local terrainType = nil
      for _, tt in ipairs(terrainTypes) do
        if perlinValue <= tt.maxHeight then
          terrainType = tt
          break
        end
      end

      local voxelX = startCoord[1] - 1 + x
      local voxelZ = startCoord[3] + mapHeight - y
      local endY = startCoord[2] + terrainType.calcHeight(perlinValue, seaLevel, heightScale)
      local startY = endY - 2
      Cosm.currentWorld:drawLine(
        {
          voxelX,
          startY,
          voxelZ,
        },
        {
          voxelX,
          endY,
          voxelZ,
        },
        terrainType.voxel,
        Cosm.DrawMode.Set
      )
    end
  end

  -- Draw sea
  Cosm.currentWorld:drawBox(
    {
      startCoord[1],
      startCoord[2] + seaLevel,
      startCoord[3],
    },
    {
      startCoord[1] + mapWidth - 1,
      startCoord[2] + seaLevel,
      startCoord[3] + mapHeight - 1,
    },
    {
      color = {62, 113, 205, 180},
      layer = Cosm.LayerType.Transparent
    },
    Cosm.DrawMode.Create
  )
end
