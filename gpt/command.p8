-- Command Pattern
Command = {}
Command.__index = Command

function Command:execute()
end

MoveCommand = setmetatable({}, {__index = Command})
MoveCommand.__index = MoveCommand

function MoveCommand:new(entity, dx, dy)
    local command = {
        entity = entity,
        dx = dx,
        dy = dy
    }
    setmetatable(command, MoveCommand)
    return command
end

function MoveCommand:execute()
    local position = self.entity:getComponent(PositionComponent)
    position.x = position.x + self.dx
    position.y = position.y + self.dy
end

-- Usage
move_baba = MoveCommand:new(baba, 1, 0)
move_baba:execute()
print(baba:getComponent(PositionComponent).x) -- Should print 2