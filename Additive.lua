require"Functions"

-- Variables ====>
local chance3to2 = 50
local separator = " "
-- <==== Variables

function getAdditive(input, chance)
	if not chance or chance == "" then chance = chance3to2 end
	local output, numof6, listof2or3, remdr = {}
	if input > 6 then
		-- if input is more than 6 then add 2 and 3 to output and minus input by 5
		output[#output + 1] = 2
		output[#output + 1] = 3
		input = input - 5
	end
	if input == 0 then return table.concat(output, separator) end
	-- get number of 6s from input
	numof6 = math.floor(input / 6)
	-- get remainder of 6
	remdr = tonumber(input) % 6
	-- if remainder is 5
	if remdr == 5 then
		-- add 3 and 2
		output[#output + 1] = 3
		output[#output + 1] = 2
	-- if remainder is 4
	elseif remdr == 4 then
		-- add pair of 2s
		output[#output + 1] = 2
		output[#output + 1] = 2
	-- if remainder is 1
	elseif remdr == 1 then
		-- remove 1 from number of 6s to form a 7
		numof6 = numof6 - 1
		-- add 3 2 2
		output[#output + 1] = 3
		output[#output + 1] = 2
		output[#output + 1] = 2
	else
		-- output same as remainder
		if remdr ~= 0 then
			output[#output + 1] = remdr
		end
	end
	for i=1, numof6 do
		listof2or3 = chanceof3(chance)
		for j,v in pairs(listof2or3) do
			output[#output + 1] = v
		end
	end
	shuffle(output); shuffle(output); shuffle(output)
	return table.concat(output, separator)
end

function chanceof3(chance)
	local output = {}
	if chance >= math.random(100) then
		for i = 1, 2 do
			output[#output + 1] = 3
		end
	else
		for i = 1, 3 do
			output[#output + 1] = 2
		end
	end
	return output
end
