__lua__
-- Rule and Constants are assumed to be global tables in PICO-8

Util = {}

function Util:getObjectsForMap(mapStr, legend)
    mapStr = mapStr or ''
    legend = legend or LEGEND
    local grid = map(self:splitMapString(mapStr), function(row, i)
        return map(row, function(char, j)
            local Block = legend[char]
            if type(Block) ~= 'function' then
                error('Could not find Block constructor in legend for "' .. char .. '"')
            end
            return Block(i, j)
        end)
    end)

    local rules = self:getDefinedRules(grid)
    return map(grid, function(row)
        return map(row, function(block)
            return self:applyRules(block, rules)
        end)
    end)
end

function Util:applyRules(block, rules)
    if not block:isIcon() then return block end
    foreach(rules, function(rule)
        if block.name == rule.target.name then
            foreach(rule.properties, function(p)
                block:addProperty(p)
            end)
        end
    end)
    if block:shouldBeDestroyed() then block:destroy() end
    return block
end

function Util:playerIsDefined(rules)
    return reduce(rules, function(isYou, rule)
        return isYou or rule:hasProperty(EFFECTS.YOU)
    end, false)
end

function Util:getDefinedRules(grid)
    return concat(self:getRulesFromRows(grid), self:getRulesFromCols(grid))
end

function Util:getRulesFromRows(grid)
    return flatMap(grid, function(row)
        return Rule:fromArray(row) or {}
    end)
end

function Util:getRulesFromCols(grid)
    local cols = map(grid[1], function(_, y)
        return map(grid, function(__, x)
            return grid[x][y]
        end)
    end)

    return self:getRulesFromRows(cols)
end

function Util:getBlockAtPosition(grid, pos)
    return grid[pos.x] and grid[pos.x][pos.y] or nil
end

function Util:getNextPosition(pos, input)
    if input == INPUTS.LEFT then
        return {x = pos.x, y = pos.y - 1}
    elseif input == INPUTS.RIGHT then
        return {x = pos.x, y = pos.y + 1}
    elseif input == INPUTS.UP then
        return {x = pos.x - 1, y = pos.y}
    elseif input == INPUTS.DOWN then
        return {x = pos.x + 1, y = pos.y}
    end
end

function Util:getDirectionFromMoveDelta(move)
    local dX = move.to.x - move.from.x
    local dY = move.to.y - move.from.y

    if dX == 0 then
        return dY > 0 and INPUTS.RIGHT or INPUTS.LEFT
    else
        return dX > 0 and INPUTS.DOWN or INPUTS.UP
    end
end

function Util:getDistanceBetweenPositions(pos1, pos2)
    if pos1.x ~= pos2.x then
        return abs(pos1.x - pos2.x)
    else
        return abs(pos1.y - pos2.y)
    end
end

function Util:sortMoves(moves)
    local sorted = sort(moves, function(move1, move2)
        if move1.from.x == move2.to.x or move1.from.y == move2.to.y then
            return false
        elseif move1.to.x == move2.from.x or move1.to.y == move2.from.y then
            return true
        else
            return nil
        end
    end)

    if #sorted > 1 then
        add(sorted, remove(sorted, 1))
    end

    return reverse(sorted)
end

function Util:deduplicateMoves(moves)
    local deduped = {}
    foreach(moves, function(move)
        if not self:arrayContainsObject(deduped, move) then
            add(deduped, move)
        end
    end)
    return deduped
end

function Util:sanitizeMapString(mapStr)
    return trim(mapStr):gsub('%s+', ' ')
end

function Util:splitMapString(mapStr)
    return map(split(trim(mapStr), '\n'), function(l)
        return split(trim(l), '')
    end)
end

function Util:arrayContainsObject(arr, obj)
    return any(arr, function(item)
        return type(item) == 'table' and self:objectsAreEqual(item, obj)
    end)
end

function Util:objectsAreEqual(obj1, obj2)
    return all(keys(obj1), function(k)
        return tostr(obj1[k]) == tostr(obj2[k])
    end)
end

function Util:getKeyForValue(obj, test)
    return reduce(keys(obj), function(result, key)
        return result or (test(obj[key]) and key or result)
    end, nil)
end

function Util:pauseForAction(ms, action)
    -- PICO-8 does not support async operations, so this function is not applicable
end