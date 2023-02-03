local util = {}

function util.inverseLerp(outMin, outMax, num)
  return (num - outMin) / (outMax - outMin)
end

return util
