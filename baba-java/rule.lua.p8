__lua__

rule = {}
rule.__index = rule

function rule:new(target, properties)
    local obj = setmetatable({}, self)
    obj.target = target
    obj.properties = properties
    return obj
end

function rule:get_name()
    local target = self.target.name
    local properties = {}
    for _, p in ipairs(self.properties) do
        table.insert(properties, p.name)
    end
    return target .. " is " .. table.concat(properties, " and ")
end

function rule:has_property(property_name)
    for _, p in ipairs(self.properties) do
        if p.name == property_name then
            return true
        end
    end
    return false
end

function rule.from_array(blocks)
    local rules = {}
    for i = 1, #blocks do
        local sample = {blocks[i], blocks[i+1], blocks[i+2], blocks[i+3], blocks[i+4]}
        local size = #sample

        if size < 3 then break end

        if (sample[1]:is_blank() and sample[3]:is_blank()) or
           (size == 3 and sample[2]:is_blank()) or
           (size == 4 and (sample[1]:is_blank() or sample[2]:is_blank() or sample[3]:is_blank())) or
           (size == 5 and (sample[1]:is_blank() or sample[2]:is_blank() or sample[3]:is_blank())) then
            goto continue
        end

        local rule = validate_rule_group(sample)
        if rule then table.insert(rules, rule) end

        ::continue::
    end

    return rules
end

function validate_rule_group(blocks)
    if #blocks < 2 or #blocks > 5 then return false end
    if all(blocks, function(b) return b:is_icon() or b:is_blank() end) then return false end

    local one = blocks[1]
    local two = blocks[2]
    local thr = blocks[3]
    local four = blocks[4]
    local five = blocks[5]

    if validate_five_blocks(one, two, thr, four, five) then
        return rule:new(one, {thr, five})
    end

    if validate_three_blocks(one, two, thr) then
        return rule:new(one, {thr})
    end

    if validate_three_blocks(two, thr, four) then
        return rule:new(two, {four})
    end

    if validate_three_blocks(thr, four, five) then
        return rule:new(thr, {five})
    end
end

function validate_five_blocks(one, two, thr, four, five)
    if not (one and two and thr and four and five) then return false end
    return one:is_noun() and two:is_joiner() and two.name == 'Is' and
           thr:is_property() and four:is_joiner() and four.name == 'And' and
           five:is_property()
end

function validate_three_blocks(one, two, thr)
    if not (one and two and thr) then return false end
    return one:is_noun() and two:is_joiner() and two.name == 'Is' and
           (thr:is_noun() or thr:is_property())
end

function all(t, f)
    for _, v in ipairs(t) do
        if not f(v) then return false end
    end
    return true
end