local util = require("util")

local noise = {}

function noise.generateNoiseMap(
  width,
  height,
  seed,
  scale,
  octaves,
  persistence,
  lacunarity,
  offset
)
  if scale <= 0 then
    scale = 0.0001
  end

  math.randomseed(seed)

  local maxPossibleHeight = 0
  local amplitude = 1
  local frequency = 1
  local octatveOffsets = {}
  for i = 1, octaves do
    local offsetX = math.random(-100000, 100000) + offset[1]
    local offsetY = math.random(-100000, 100000) - offset[2]
    octatveOffsets[i] = {offsetX, offsetY}

    maxPossibleHeight = maxPossibleHeight + amplitude
    amplitude = amplitude * persistence
  end

  local noiseMap = {}
  local maxLocalNoiseHeight = -999999
  local minLocalNoiseHeight = 999999

  for x = 1, width do
    noiseMap[x] = {}
    for y = 1, height do
      amplitude = 1
      frequency = 1

      local noiseHeight = 0

      for octave = 1, octaves do
        local noiseX = (x + octatveOffsets[octave][1]) / scale * frequency
        local noiseY = (y + octatveOffsets[octave][2]) / scale * frequency

        -- Remap from `0-1` to `-1-1`
        local perlinValue = Cosm.math:perlinNoise(noiseX, noiseY) * 2 - 1

        noiseHeight = noiseHeight + perlinValue * amplitude
        amplitude = amplitude * persistence
        frequency = frequency * lacunarity
      end

      if noiseHeight > maxLocalNoiseHeight then
        maxLocalNoiseHeight = noiseHeight
      elseif noiseHeight < minLocalNoiseHeight then
        minLocalNoiseHeight = noiseHeight
      end

      noiseMap[x][y] = noiseHeight
    end
  end

  -- Remap all values to 0-~1
  for x = 1, width do
    for y = 1, height do
      local heightModifier = 1.8
      local normalizedHeight = (noiseMap[x][y] + 1) / (2 * maxPossibleHeight / heightModifier)
      noiseMap[x][y] = math.max(normalizedHeight, 0)
    end
  end

  return noiseMap
end

return noise
