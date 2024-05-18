__lua__

noun_base = {}
noun_base.__index = noun_base

function noun_base:initialize()
    self.type = TYPES.NOUN
end

baba = setmetatable({}, noun_base)
baba.__index = baba

door = setmetatable({}, noun_base)
door.__index = door

flag = setmetatable({}, noun_base)
flag.__index = flag

keke = setmetatable({}, noun_base)
keke.__index = keke

key = setmetatable({}, noun_base)
key.__index = key

lava = setmetatable({}, noun_base)
lava.__index = water

rock = setmetatable({}, noun_base)
rock.__index = rock

skull = setmetatable({}, noun_base)
skull.__index = skull

text = setmetatable({}, noun_base)
text.__index = text

wall = setmetatable({}, noun_base)
wall.__index = wall

water = setmetatable({}, noun_base)
water.__index = water
