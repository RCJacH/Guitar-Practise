-- Variables ====>
local a_elementNames = {["n"] = "Even", ["t"] = "Triplet", ["u"] = "Tuplet"}
local i_number = 1
local separator = " | "
local s_nHex = '0123456789ABCDEF'
local s_tHex = '0123ABCF'
local s_aHex = '56789'
local chance3to2 = 50
-- <==== Variables
require"Functions"

function getRhythm(input)
  -- Split input to select element
  -- if Even
  if input[1] == "n" then
    return defineRhythm(input[2], 4)
  -- if Triplet
  elseif input[1] == "t" then
    return defineRhythm(input[2], 3)
  -- if Tuplet
  elseif input[1]:match 'u' then
    
  end
end

function defineRhythm(input, number)
  -- This Function take input div, pat into visualized pattern
  local outpat=""
  input = tonumber(input, 16)
  if input >= 1 and input <= 4 then
    for i = 1, number do
      if i == input then
        outpat = outpat.."X"
      else
        outpat = outpat.."."
      end
    end
  elseif input >= 10 and input <= 13 then
    input = input - 9
    for i = 1, number do
      if i ~= input then
        outpat = outpat.."X"
      else
        outpat = outpat.."."
      end
    end
  elseif input == 5 or input == 7 or input == 9 then
    input = math.floor(input/2) - 1
    for i = 1, number do
      if i == input or i == input+1 then
        outpat = outpat.."X"
      else
        outpat = outpat.."."
      end
    end
  elseif input == 6 then
    outpat = "X.X."
  elseif input == 8 then
    outpat = ".X.X"
  elseif input == 14 then
    outpat = "X..X"
  elseif input == 15 then
    for i = 1, number do
        outpat = outpat.."X"
    end
  else
    for i = 1, number do
        outpat = outpat.."."
    end
  end
  return outpat
end

function RandomizeRhythm(number,ele,style,tuplet)

  -- set default
  if not number then number = 1 end
  if not style then style = 1 end
  if not tuplet then tuplet = 0 end
  local list, eleList,output = {}, {"n","t","u"}, ""
  local lastEle, s_list
  -- for number loop
  for i = 1, number do
    local perEle, rnd, hex, element
    -- Randomize Element
    if not ele or ele == "nil" or ele == "" then
      perEle = eleList[math.random(2+tuplet)]
    else
      perEle = ele
    end
    -- Define taking from what Element
    if perEle == "n" then
      element = s_nHex
    elseif perEle == "t" then
      element = s_tHex
    elseif perEle == "u" then
      element = s_aHex
    end
    -- Randomize Pattern
    rnd = (math.random(string.len(element)))
    hex = string.sub(element,rnd,rnd)
    -- Add "/" for Asterisk Tuplets 
    if perEle == "u" then hex = hex.."/" end
    -- Ignore Repeated Elements
    if perEle == lastEle then
      list[#list + 1] = hex
    else
      list[#list + 1] = perEle..hex
      lastEle = perEle
    end
  end
  -- toString
  s_list = table.concat(list)
  -- Output Hex or Pattern Visual
  if style == 1 then
    return s_list
  else
      -- Get Pattern Pairs
      patlist = splitPat(s_list)
      -- Return Output String
      for i = 1, #patlist do
        local patVisual = getRhythm(patlist[i])
        output = output..patVisual
        if i ~= #patlist then output = output.." " end
      end
    return output
  end
end

function splitPat(input)
  --[[ This Function is used to split a Hex String into Pattern Pairs
  ie. n36tAn1 -> {n3, n6, tA, n1} ]]
  local a_listIn, a_listOut, a_listOut2 = {},{},{}
  -- Split input string into each Div, Pats
  for div, pat in string.gmatch(input, "([%l]*)([%x%d]+)") do
      a_listIn[#a_listIn + 1] = {div, pat}
  end
  -- Split each Div into Pat Pairs
  for _, v in ipairs(a_listIn) do
      for pair in string.gmatch(v[2],"[%x%d]") do 
          a_listOut[#a_listOut + 1] = {v[1], pair}
      end
  end
  return a_listOut
end

function getAdditive(input, chance)
  if not chance or chance == "" then chance = chance3to2 end
  local output, numof6, listof2or3, remdr = {}
  if input > 6 then
    -- if input is more than 6 then add 2 and 3 to output and minus input by 5
    output[#output + 1] = 2
    output[#output + 1] = 3
    input = input - 5
  end
  if input == 0 then return table.concat(output, " ") end
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
