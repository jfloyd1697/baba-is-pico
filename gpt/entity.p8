-- Entity Component System
Entity = {}
Entity.__index = Entity

function Entity:new()
    local entity = {
        components = {}
    }
    setmetatable(entity, Entity)
    return entity
end

function Entity:addComponent(component)
    self.components[component.__index] = component
end

function Entity:getComponent(componentClass)
    return self.components[componentClass]
end

PositionComponent = {}
PositionComponent.__index = PositionComponent

function PositionComponent:new(x, y)
    local component = {
        x = x,
        y = y
    }
    setmetatable(component, PositionComponent)
    return component
end

SpriteComponent = {}
SpriteComponent.__index = SpriteComponent

function SpriteComponent:new(sprite)
    local component = {
        sprite = sprite
    }
    setmetatable(component, SpriteComponent)
    return component
end

-- Usage
baba = Entity:new()
baba:addComponent(PositionComponent:new(1, 1))
baba:addComponent(SpriteComponent:new("BabaSprite"))