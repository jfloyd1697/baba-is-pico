--baba

function _init()
--spt,text,type,move,touch,color
tile={
{65,false,"flag",0,"win",{10,10}},
{64,false,"wall","stop",0,{5,5}},
{66,false,"rock","push",0,{4,4}},
{32,true,"baba","push",0,{2,8}},
{33,true,"wall","push",0,{1,5}},
{34,true,"flag","push",0,{4,10}},
{35,true,"rock","push",0,{2,4}},
{36,true,"is","push",0,{5,7}},
{48,true,"you","push",0,{2,8}},
{49,true,"stop","push",0,{3,11}},
{50,true,"win","push",0,{4,10}},
{51,true,"push","push",0,{2,4}},
{193,false,"baba","you","you",{7,7}}

}


obj={}

local Baba = class()
function Baba:init()
    self.x = 0
    self.y = 0
    self.sprite = 1
    self.is = "baba"
    self.flags = {OBJECTS.BABA, ATTRIBUTES.YOU}
end

function create_object()

function _update()
	for b in all(obj) do
		b:control(obj)
	end
end

function _draw()
	cls()
	map()
	for b in all(obj) do
		b:babadir(obj)
	end
	foreach(obj,draw_objs)

end

-- functions

function drawspr(_spr,_x,_y,_c)
pal(1,0)
pal(5,_c)
spr(_spr,_x*8,_y*8)
pal()
end


function draw_objs(_obs)
	drawspr(
        _obs.spr,
        _obs.x,
        _obs.y,
        _obs.color[2]
    )
end

function find_objs()
	for i=1,#tile do
		for y=1,16 do for x=1,16 do
			if (mget(x,y) == tile[i][1]) then
				make_obj(x,y,tile[i])
					mset(x,y,0)
				end
			end
		end
	end
end

function is_stop(obj)
    if obj.flags.includes(ATTRIBUTES.STOP) then
        return true
    end
    return false
end


function move(obj) {
    if not 
}







function make_obj(_x,_y,_t)
	local o = {
	    x=_x
	    y=_y
	    spr=_t[1]
	    text=_t[2]
	    type=_t[3]
	    move=_t[4]
	    touch=_t[5]
	    color=_t[6]

	    control=function(self)
			if self.move == "you" then
			local dirx={-1,1,0,0}
			local diry={0,0,-1,1}
				for i=0,3 do
					if btnp(i) then
						self.x+=dirx[i+1]
						self.y+=diry[i+1]
						sfx(60)
						return
					end
				end
			end
		end

        move=function(self, _btn)
            local d = {
                [0] = {x = -1, y = 0, spr = 192},
                [1] = {x = 1, y = 0, spr = 193},
                [2] = {x = 0, y = -1, spr = 194},
                [3] = {x = 0, y = 1, spr = 195}
            }
            if d[dir] == nil then return end
            self.x += d[dir].x
            self.y += d[dir].y
            self.spr = d[dir].spr
        end

		babadir=function(self)
			if self.type == "baba" and
				 self.move == "you" then
				for i=0,3 do
					if btnp(i) then
						self.spr=192+i
					return
					end
				end
			end
		end
    }

    add(obj, o)
end