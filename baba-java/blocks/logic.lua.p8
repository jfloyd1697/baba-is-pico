__lua__

joiner_base = {}
joiner_base.__index = joiner_base

function joiner_base:initialize()
    self.type = TYPES.JOINER
end

IS = setmetatable({}, joiner_base)
IS.__index = IS

AND = setmetatable({}, joiner_base)
AND.__index = AND