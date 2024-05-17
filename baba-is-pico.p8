local enum = function(keys)
    local Enum = {}
    for _, value in ipairs(keys) do
        Enum[value] = {} 
    end
    return Enum
end


local OBJECTS = enum{
    "BABA", "FLAG", "WALL", 
    "ROCK", "KEY", "DOOR", 
    "WATER", "LAVA", "SKULL", 
    "GRASS", "TEXT", "STAR", 
    "TREE", "CLOUD", "FENCE", 
    "BRICK", "LEAF", "BUSH", 
    "HOUSE", "MOUNTAIN", 
    "SUN", "MOON", "STAR", 
    "CIRCLE", "SQUARE", "KEKE",
    "JELLY", "CRAB",
}

local DIRECTIONS = enum{
    "UP", "DOWN", "LEFT", "RIGHT"
}

local ATTRIBUTES = enum{
    "MOVE", "PUSH", "STOP",
    "SINK", "HOT", "WIN"
    "OPEN", "SHUT", "FLOAT",
    "MELT", "DEFEAT", "YOU",
    "PULL", "SHIFT", "TELE",
    "FALL", "WEAK", "HIDE",
}



local Object {
    x = 0,
    y = 0,
    sprite = 0,
    is = "object",
    flags = {},
    move = function(self, dx, dy)
        self.x += dx
        self.y += dy
    end,
    update = function(self)
        -- Update the object
    end,
    draw = function(self)
        draw(self.sprite, self.x, self.y)
    end
}


local Baba = Object {
    sprite = 1,
    is = "baba",
    flags = {OBJECTS.BABA, ATTRIBUTES.YOU, ATTRIBUTES.MOVE}
}

local Flag = Object {
    sprite = 2,
    is = "flag",
    flags = {OBJECTS.FLAG, ATTRIBUTES.WIN}
}

local Wall = Object {
    sprite = 3,
    is = "wall",
    flags = {OBJECTS.WALL, ATTRIBUTES.STOP}
}

local Rock = Object {
    sprite = 4,
    is = "rock",
    flags = {OBJECTS.ROCK, ATTRIBUTES.PUSH}
}

local Key = Object {
    sprite = 5,
    is = "key",
    flags = {OBJECTS.KEY, ATTRIBUTES.OPEN}
}

local Door = Object {
    sprite = 6,
    is = "door",
    flags = {OBJECTS.DOOR, ATTRIBUTES.SHUT}
}




function _init()
    
end

function _update60()
    
end

function _draw()
    
end