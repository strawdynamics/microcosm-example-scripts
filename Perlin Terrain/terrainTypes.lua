local terrainTypes = {
  {
    name = 'deepUnderwater',
    maxHeight = 0.3,
    voxel = {
      color = {140, 140, 111},
      layer = Cosm.LayerType.Solid,
    },
    calcHeight = function(perlinHeight, seaLevel, heightScale)
      return perlinHeight * heightScale
    end
  },
  {
    name = 'shallowUnderwater',
    maxHeight = 0.4,
    voxel = {
      color = {190, 189, 123},
      layer = Cosm.LayerType.Solid,
    },
    calcHeight = function(perlinHeight, seaLevel, heightScale)
      return perlinHeight * heightScale
    end
  },
  {
    name = 'sand',
    maxHeight = 0.45,
    voxel = {
      color = {216, 214, 136},
      layer = Cosm.LayerType.Solid,
    },
    calcHeight = function(perlinHeight, seaLevel, heightScale)
      return perlinHeight * heightScale
    end
  },
  {
    name = 'grass',
    maxHeight = 0.55,
    voxel = {
      color = {95, 162, 22},
      layer = Cosm.LayerType.Solid,
    },
    calcHeight = function(perlinHeight, seaLevel, heightScale)
      return perlinHeight * heightScale
    end
  },
  {
    name = 'mouantainGrass',
    maxHeight = 0.65,
    voxel = {
      color = {71, 118, 15},
      layer = Cosm.LayerType.Solid,
    },
    calcHeight = function(perlinHeight, seaLevel, heightScale)
      return perlinHeight * heightScale
    end
  },
  {
    name = 'foothills',
    maxHeight = 0.75,
    voxel = {
      color = {97, 72, 66},
      layer = Cosm.LayerType.Solid,
    },
    calcHeight = function(perlinHeight, seaLevel, heightScale)
      return perlinHeight * heightScale
    end
  },
  {
    name = 'mountains',
    maxHeight = 0.9,
    voxel = {
      color = {77, 60, 57},
      layer = Cosm.LayerType.Solid,
    },
    calcHeight = function(perlinHeight, seaLevel, heightScale)
      return perlinHeight * heightScale
    end
  },
  {
    name = 'snowcaps',
    maxHeight = 2,
    voxel = {
      color = {255, 255, 255},
      layer = Cosm.LayerType.Solid,
    },
    calcHeight = function(perlinHeight, seaLevel, heightScale)
      return perlinHeight * heightScale
    end
  },
}

return terrainTypes
