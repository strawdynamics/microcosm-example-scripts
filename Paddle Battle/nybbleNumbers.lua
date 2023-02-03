local numbers = {
  -- 0
  {
    {1, 2, 1},
    {2, 1, 2},
    {2, 1, 2},
    {1, 2, 1},
  },
  -- 1
  {
    {1, 2, 1},
    {2, 2, 1},
    {1, 2, 1},
    {2, 2, 2},
  },
  -- 2
  {
    {2, 2, 1},
    {1, 1, 2},
    {1, 2, 1},
    {2, 2, 2},
  },
  -- 3
  {
    {2, 2, 1},
    {1, 1, 2},
    {1, 2, 2},
    {2, 2, 2},
  },
  -- 4
  {
    {2, 1, 1},
    {2, 2, 1},
    {2, 2, 2},
    {1, 2, 1},
  },
  -- 5
  {
    {2, 2, 2},
    {2, 1, 1},
    {1, 2, 2},
    {2, 2, 2},
  },
  -- 6
  {
    {1, 2, 1},
    {2, 1, 1},
    {2, 2, 2},
    {2, 2, 2},
  },
  -- 7
  {
    {2, 2, 2},
    {1, 1, 2},
    {1, 2, 1},
    {1, 2, 1},
  },
  -- 8
  {
    {2, 2, 2},
    {1, 2, 1},
    {2, 1, 2},
    {2, 2, 2},
  },
  -- 9
  {
    {1, 2, 2},
    {2, 2, 2},
    {1, 1, 2},
    {1, 2, 1},
  },
}

nybbleNumbers = {}

nybbleNumbers.width = 3
nybbleNumbers.height = 4

-- 0-9
-- {emptyVoxel, filledVoxel}
-- {x, y, z}
function nybbleNumbers.drawNumber(num, palette, topLeft)
  -- Adjust for Lua 1-based indexing
  num = num + 1
  number = numbers[num]

  for numberY, row in ipairs(number) do
    for numberX, paletteIndex in ipairs(row) do
      voxel = palette[paletteIndex]
      coord = {
        topLeft[1] + numberX - 1,
        topLeft[2] - numberY + 1,
        topLeft[3],
      }

      Cosm.currentWorld:drawVoxel(
        coord,
        voxel,
        Cosm.DrawMode.Set
      )
    end
  end
end
