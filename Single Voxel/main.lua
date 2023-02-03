local randomVoxel = {
  color = {math.random(0, 255), math.random(0, 255), math.random(0, 255)},
  layer = Cosm.LayerType.Solid
}

function start()
  Cosm.currentWorld:drawVoxel(
    Cosm.cursor.coord,
    randomVoxel,
    Cosm.DrawMode.Set
  )
end
