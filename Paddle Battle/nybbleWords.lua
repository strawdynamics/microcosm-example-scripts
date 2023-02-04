local words = {
  win = {
    {2, 1, 1, 1, 2, 1, 2, 2, 2, 1, 2, 2, 1},
    {2, 1, 1, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2},
    {2, 1, 2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2},
    {1, 2, 2, 2, 2, 1, 2, 2, 2, 1, 2, 1, 2},
  },
  lose = {
    {2, 1, 1, 1, 2, 2, 1, 1, 2, 2, 1, 2, 2, 2},
    {2, 1, 1, 2, 1, 2, 1, 2, 1, 1, 1, 2, 1, 1},
    {2, 1, 1, 2, 1, 2, 1, 1, 2, 2, 1, 2, 2, 1},
    {2, 2, 1, 2, 2, 1, 1, 2, 2, 1, 1, 2, 2, 2},
  }
}

nybbleWords = {}

nybbleWords.height = 4
nybbleWords.winWidth = 13
nybbleWords.loseWidth = 14

-- word
-- {emptyVoxel, filledVoxel}
-- {x, y, z}
function nybbleWords.drawWord(word, palette, topLeft)
  local wordData = words[word]

  for wordY, row in ipairs(wordData) do
    for wordX, paletteIndex in ipairs(row) do
      voxel = palette[paletteIndex]
      coord = {
        topLeft[1] + wordX - 1,
        topLeft[2] - wordY + 1,
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
