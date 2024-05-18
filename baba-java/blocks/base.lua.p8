__lua__

base = {}
base.__index = base

function base:new(x, y)
    local obj = setmetatable({}, self)
    obj.position = {x = x or -1, y = y or -1}
    obj.properties = {}
    obj:initialize()
    return obj
end

function base:initialize()
    self.type = TYPES.BASE
end

function base:add_property(property)
    table.insert(self.properties, property)
end

function base:has_property(property)
    for _, p in ipairs(self.properties) do
        if p:has_effect(property) then
            return true
        end
    end
    return false
end

function base:set_position(x, y)
    self.position = {x = x, y = y}
end

function base:set_type(type)
    self.type = type
end

function base:destroy()
    self.type = TYPES.BLANK
    self.properties = {}
end

function base:is_solid()
    return self:has_property(EFFECTS.SOLID)
end

function base:is_movable()
    for _, p in ipairs(self.properties) do
        if p:has_effect(EFFECTS.SOLID) and p:has_effect(EFFECTS.MOVABLE) then
            return true
        end
    end
    return false
end

function base:is_steppable()
    return not self:is_solid()
end

function base:is_you()
    return self:has_property(EFFECTS.YOU)
end

function base:is_win()
    return self:has_property(EFFECTS.WIN)
end

function base:is_float()
    return self:has_property(EFFECTS.FLOAT)
end

function base:is_defeat()
    return self:has_property(EFFECTS.DEFEAT)
end

function base:is_sink()
    return self:has_property(EFFECTS.SINK)
end

function base:is_melt()
    return self:has_property(EFFECTS.MELT)
end

function base:is_hot()
    return self:has_property(EFFECTS.HOT)
end

function base:is_blank()
    return self.type == TYPES.BLANK
end

function base:is_icon()
    return self.type == TYPES.ICON
end

function base:is_noun()
    return self.type == TYPES.NOUN
end

function base:is_joiner()
    return self.type == TYPES.JOINER
end

function base:is_property()
    return self.type == TYPES.PROPERTY
end

function base:is_word()
    return self:is_noun() or self:is_joiner() or self:is_property()
end

function base:should_be_destroyed()
    return self:is_hot() and self:is_melt()
end

blank = setmetatable({}, base)
blank.__index = blank

function blank:initialize()
    self:set_type(TYPES.BLANK)
end