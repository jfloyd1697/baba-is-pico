__lua__
-- Util functions are assumed to be global functions in PICO-8

History = {}
History.__index = History

function History:new()
    local obj = setmetatable({}, self)
    obj.commits = {}
    obj.coveredBlocks = {}
    obj.legend = LEGEND
    return obj
end

function History:push(change)
    add(self.commits, change)
end

function History:revert(count)
    count = count or -1
    if count < 0 then
        self.commits = {self.commits[1]}
    elseif #self.commits > count then
        self.commits = sub(self.commits, 1, #self.commits - count)
    end
end

function History:applyChanges(diff)
    local last = splitMapString(self.last)
    local newState = reduce(diff, function(state, delta)
        local fromBlock = state[delta.from.x][delta.from.y]
        local toBlock = state[delta.to.x][delta.to.y]

        if not delta.to.destroyed then
            self:coverBlock({
                x = delta.to.x,
                y = delta.to.y,
                char = toBlock
            })
        end

        state[delta.to.x][delta.to.y] = self:getNewTo(delta, fromBlock, toBlock)
        state[delta.from.x][delta.from.y] = self:getNewFrom(delta, fromBlock, toBlock)

        return state
    end, last)

    self:push(
        join(map(newState, function(l) return join(l, '') end), '\n')
    )
end

function History:coverBlock(block)
    if block.char ~= self.BLANK and not arrayContainsObject(self.coveredBlocks, block) then
        add(self.coveredBlocks, block)
    end
end

function History:getNewFrom(delta, fromBlock, toBlock)
    return self:getPrevBlock(delta.from) or self.BLANK
end

function History:getNewTo(delta, fromBlock, toBlock)
    if delta.to.destroyed then
        return self:getPrevBlock(delta.to) or self.BLANK
    end

    return delta.from.destroyed and toBlock or fromBlock
end

function History:getPrevBlock(pos)
    local index = findIndex(self.coveredBlocks, function(block)
        return block.x == pos.x and block.y == pos.y
    end)

    if index > -1 then
        local prev = remove(self.coveredBlocks, index)
        return prev.char
    end

    return nil
end

function History:get_last()
    return self.commits[#self.commits]
end

function History:get_legend()
    return self.legend
end

function History:set_legend(val)
    self.legend = val
end

function History:get_BLANK()
    return getKeyForValue(self.legend, function(val)
        return val.name == 'Blank'
    end)
end

function History.of(initialState)
    local hist = History:new()
    hist:push(initialState)
    return hist
end