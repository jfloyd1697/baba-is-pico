__lua__
-->8
-- PROPERTY
property_base = {}
property_base.__index = property_base

function property_base:initialize()
    self.type = TYPES.PROPERTY
    self.effects = {}
    self:set_effects()
end

function property_base:set_effect(key, value)
    self.effects[key] = value
end

function property_base:has_effect(key)
    return self.effects[key] ~= nil
end

-->8
-- DEFEAT
defeat = setmetatable({}, property_base)
defeat.__index = defeat

function defeat:set_effects()
    self:set_effect(EFFECTS.DEFEAT, true)
end    

-->8
-- FLOAT
float = setmetatable({}, property_base)
float.__index = float

function float:set_effects()
    self:set_effect(EFFECTS.FLOAT, true)
end

-->8
-- HOT
hot = setmetatable({}, property_base)
hot.__index = hot

function hot:set_effects()
    self:set_effect(EFFECTS.HOT, true)
end


-->8
-- MELT
melt = setmetatable({}, property_base)
melt.__index = melt

function melt:set_effects()
    self:set_effect(EFFECTS.MELT, true)
end

-->8
-- MOVE
move = setmetatable({}, property_base)
move.__index = move

function move:set_effects()
    self:set_effect(EFFECTS.MOVABLE, true)
end

-->8
-- OPEN
open = setmetatable({}, property_base)
open.__index = open

function open:set_effects()
    self:set_effect(EFFECTS.OPEN, true)
end

-->8
-- PUSH
push = setmetatable({}, property_base)
push.__index = push

function push:set_effects()
    self:set_effect(EFFECTS.SOLID, true)
    self:set_effect(EFFECTS.MOVABLE, true)
end

-->8
-- SINK
sink = setmetatable({}, property_base)
sink.__index = sink

function sink:set_effects()
    self:set_effect(EFFECTS.SINK, true)
end    

-->8
-- STOP
stop = setmetatable({}, property_base)
stop.__index = stop

function stop:set_effects()
    self:set_effect(EFFECTS.SOLID, true)
end    

-->8
-- WIN
win = setmetatable({}, property_base)
win.__index = win

function win:set_effects()
    self:set_effect(EFFECTS.WIN, true)
end

-->8
-- YOU
you = setmetatable({}, property_base)
you.__index = you

function you:set_effects()
    self:set_effect(EFFECTS.YOU, true)
end
