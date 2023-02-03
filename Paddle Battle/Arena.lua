Arena = {}
Arena.__index = Arena

local playingFieldVoxel = {
  color = {234, 234, 234},
  layer = Cosm.LayerType.Solid
}

local wallAndNetVoxel = {
  color = {177, 177, 178},
  layer = Cosm.LayerType.Solid
}

-- width and height should be odd
function Arena.Create(startCoord, width, height)
  local arena = {}

  setmetatable(arena, Arena)
  arena.startCoord = startCoord
  arena.width = width
  arena.height = height
  arena.minX = startCoord[1] - math.floor(width / 2)
  arena.minY = startCoord[2]
  arena.maxX = startCoord[1] + math.floor(width / 2)
  arena.maxY = startCoord[2] + height - 1

  return arena
end

function Arena:Draw()
  -- Move z a few voxels "away" from start
  local playingFieldZ = self.startCoord[3] + 3

  local bottomLeft = {self.minX, self.minY, playingFieldZ}

  local topRight = {self.maxX, self.maxY, playingFieldZ}

  -- Replace all arena space with undo enabled, to allow reverting after match
  -- is complete
  Cosm.currentWorld:drawBox(
    bottomLeft,
    {self.maxX, self.maxY, self.startCoord[3]},
    playingFieldVoxel,
    Cosm.DrawMode.Set,
    true
  )
  -- Delete the temporary "undo box"
  Cosm.currentWorld:drawBox(
    bottomLeft,
    {self.maxX, self.maxY, self.startCoord[3]},
    nil,
    Cosm.DrawMode.Delete
  )

  -- Draw playing field
  Cosm.currentWorld:drawBox(
    bottomLeft,
    topRight,
    playingFieldVoxel,
    Cosm.DrawMode.Set
  )

  -- Draw walls
  local wallBottomZ = playingFieldZ - 1
  local wallTopZ = self.startCoord[3]

  -- Draw left wall
  local leftWallBottomLeft = {self.minX, self.minY, wallBottomZ}
  local leftWallTopRight = {self.minX, self.maxY, wallTopZ}
  Cosm.currentWorld:drawBox(
    leftWallBottomLeft,
    leftWallTopRight,
    wallAndNetVoxel,
    Cosm.DrawMode.Set
  )

  -- Draw right wall
  local rightWallBottomLeft = {self.maxX, self.minY, wallBottomZ}
  local rightWallTopRight = {self.maxX, self.maxY, wallTopZ}
  Cosm.currentWorld:drawBox(
    rightWallBottomLeft,
    rightWallTopRight,
    wallAndNetVoxel,
    Cosm.DrawMode.Set
  )

  -- Draw net
  local netY = self.minY + math.floor(self.height / 2)
  for netX = self.minX, self.maxX, 2 do
    Cosm.currentWorld:drawVoxel(
      {netX, netY, wallBottomZ},
      wallAndNetVoxel,
      Cosm.DrawMode.Set
    )
  end
end
