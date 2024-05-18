__lua__

movement = {}
movement.__index = movement

function movement:new(grid)
    local obj = setmetatable({}, self)
    obj.grid = grid
    return obj
end

function movement:get_legal_moves(direction)
    local player_moves = self:get_player_moves(direction)
    return sort_moves(
        deduplicate_moves(
            self:walk_moves(player_moves, direction)
        )
    )
end

function movement:walk_moves(moves, direction, depth)
    depth = depth or 0
    if #moves == 0 or depth > #moves then return moves end

    local queue = {}
    local first_block_in_chain = nil
    local legal_moves = filter(map(moves, function(move)
        local from_block = get_block_at_position(self.grid, move.from)
        local to_block = get_block_at_position(self.grid, move.to)
        local last_block_in_chain = self:get_last_block_in_chain(from_block, move.to)
        local block_after_chain = get_block_at_position(
            self.grid,
            get_next_position(last_block_in_chain.position, direction)
        )
        local can_move_first_block = self:block_can_be_moved_to(from_block, move.to)
        local can_move_last_block = block_after_chain and self:block_can_be_moved_to(last_block_in_chain, block_after_chain.position) or false
        local chain_length = get_distance_between_positions(
            first_block_in_chain and first_block_in_chain.position or from_block.position,
            last_block_in_chain and last_block_in_chain.position or to_block.position
        )

        if first_block_in_chain == nil then
            first_block_in_chain = from_block
        end

        if not can_move_first_block or not to_block or not block_after_chain or not can_move_last_block then
            return false
        end

        if last_block_in_chain:is_sink() or to_block:is_sink() then
            move.from.destroyed = true
            move.to.destroyed = true
        end

        if from_block:is_melt() and to_block:is_hot() then
            move.from.destroyed = true
        end

        if from_block:is_you() and to_block:is_defeat() then
            move.from.destroyed = true
        end

        if last_block_in_chain:is_steppable() or to_block:is_steppable() then
            return move
        end

        if chain_length < #queue then
            return move
        end

        if to_block:is_movable() then
            local next_move = {
                from = to_block.position,
                to = get_next_position(to_block.position, direction)
            }

            if not array_contains_object(queue, move) then
                add(queue, move)
            end
            if not array_contains_object(queue, next_move) then
                add(queue, next_move)
            end
        end
    end), function(move) return move end)

    return extend(legal_moves, self:walk_moves(queue, direction, depth + 1))
end

function movement:get_last_block_in_chain(block, pos)
    local next_block = get_block_at_position(self.grid, pos)
    local direction = get_direction_from_move_delta({
        from = block.position,
        to = pos
    })

    if not next_block or not next_block:is_movable() then
        return block
    end
    return self:get_last_block_in_chain(
        next_block,
        get_next_position(next_block.position, direction)
    )
end

function movement:block_can_be_moved_to(block, pos)
    local destination = get_block_at_position(self.grid, pos)
    if not destination then return false end
    local next_pos = get_next_position(destination.position, get_direction_from_move_delta({
        from = block.position,
        to = pos
    }))

    if destination:is_steppable() then return true end
    if destination:is_movable() then
        return self:block_can_be_moved_to(destination, next_pos)
    end
end

function movement:get_player_moves(input)
    return map(self:get_player_icons(), function(icon)
        return {
            from = icon.position,
            to = get_next_position(icon.position, input)
        }
    end)
end

function movement:get_player_icons()
    return flat_map(self.grid, function(row)
        return filter(row, function(block)
            return block:is_icon() and block:is_you()
        end)
    end)
end