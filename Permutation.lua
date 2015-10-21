-- Variables ====>
local a_gVar = {}
local a_2Var = {}
local a_3Var = {}
local a_4Var = {}
local s_rep, s_antcp, s_camb, s_echa, s_gopass, s_goaway, s_chngU, s_chngD, s_psng, s_dbpsng
local language = "English"
if language == "English" then
  s_rep, s_antcp, s_camb, s_echa, s_gopass, s_goaway, s_chngU, s_chngD, s_psng, s_dbpsng = "Repeat", "Anticipation", "Cambiata", "Echappee", "Going Pass", "Going Away", "Changing Note Up", "Changing Note Down", "Passing Note", "Double Passing Note"
end
-- <=== Variables
require"Functions"


function genPermutation(inList, number)
  -- Get Permutation of Varied length
  local pList = {}
  -- if no input or input is an integer
  if not inList or type(inList) == "number" or inlist == "" then
    if type(inList) == "number" then
      if not number then number = inList end
    else
      if not number then number = 4 end
    end
    -- build content list
    for i=1, number do
      pList[#pList + 1] = i
    end
  -- if input table
  elseif type(inList) == "table" then
    for i=1, #inList do
      if i>=2 and i <= #inList-2 then
        pList[#pList + 1] = inlist[i]
      end
    end
  end
  local gList, output = pList, {}
  -- Build output
  for i=1, #pList do
    local index
    while not index or index == "" do
      index = math.random(#gList)
    end
    output[#output+1] = pList[index]
    table.remove(gList, index)
  end
  return table.concat(output)
end

function genPSeconds()
  local vari = {s_rep, s_antcp, s_camb, s_echa, s_gopass, s_goaway, s_chngU, s_chngD}
  return vari[math.random(#vari)]
end

function genPThirds()
  local vari = {s_camb, s_echa, s_gopass, s_goaway, s_chngU, s_chngD, s_psng}
  return vari[math.random(#vari)]
end

function genPFourths()
  local vari = {s_camb, s_echa, s_chngU, s_chngD, s_dbpsng}
  return vari[math.random(#vari)]
end