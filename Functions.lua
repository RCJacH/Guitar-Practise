math.randomseed(tostring(os.time()):reverse():sub(1, 6))
math.random();math.random();math.random()

function strComp(input, comp)
    if not input or not comp then return end
    if input == string.lower(comp) or string.lower(input) == string.lower(comp) then return true else return false end
end

function trim(s) 
  return (string.gsub(s, "^%s*(.-)%s*$", "%1")) 
end

-- local function shuffle( a )
-- 	local c = #a
-- 	for i = 1, (c * 20) do
-- 		local ndx0 = math.random( 1, c )
-- 		local ndx1 = math.random( 1, c )
-- 		local temp = a[ ndx0 ]
-- 		a[ ndx0 ] = a[ ndx1 ]
-- 		a[ ndx1 ] = temp
-- 	end
--     return a
-- end

function shuffle(t)
    for i = #t,1,-1 do
        local j = math.random(1, i)
        -- exchange t[i] and t[j]
        local tmp = t[i]
        t[i] = t[j]
        t[j] = tmp
    end
end