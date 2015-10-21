-- Variables ====>
local s_iolianm, s_dorianm, s_phrygianm, s_lydianm, s_mixom, s_aeolianm, s_locrianm, s_indexf, s_midf, s_ringf, s_pinkyf, s_allf
language = "English"
-- Names
if language == "English" then
  s_iolianm = "Iolian"
  s_dorianm = "Dorian"
  s_phrygianm = "Phrygian"
  s_lydianm = "Lydian"
  s_mixom = "Mixolydian"
  s_aeolianm = "Aeolian"
  s_locrianm = "Locrian"
  s_thumbf = "Thumb"
  s_indexf = "Index"
  s_midf = "Middle"
  s_ringf = "Ring"
  s_pinkyf = "Pinky"
  s_allf = "All"
end
-- Lists
local modes = {s_iolianm, s_dorianm, s_phrygianm, s_lydianm, s_mixom, s_aeolianm, s_locrianm}

local root = {"C", "C#", "Db", "D", "D#", "Eb", "E", "F", "F#", "Gb", "G", "G#", "Ab", "A", "A#", "Bb", "B", }

local a_fingers = {s_indexf, s_midf, s_ringf, s_pinkyf, s_thumbf}

-- Others

-- <==== Variables
require"Functions"


function getFingers(number, ins)
  local i_gtrLH = 0
  -- Initialize output list from constant
  local output = {}
  for i, v in pairs(a_fingers) do
    output[i] = v
  end
  if ins == "Guitar" then table.remove(output) end  
  -- If no input then randomize input
  if not number then number = math.random(#output - 1) end
  -- If input is equal or greater than 4 then return
  if number >= 5 then return s_allf end
  local rnd, outstring
  -- Nil-ify random list item
  for i=1, #output - number do
    output[math.random(#output)] = ""
  end
  -- Concat to string
  outstring = table.concat(output, " ")
  -- Trim Spaces
  outstring = trim(string.gsub(outstring, "%s+", " "))
  return outstring 
end

function getFret(high, low)
  if not low then low = 0 end
  if not high then high = 9 end
  return math.random(low, high)
end

function getString(num)
  for i=1, num do

  end
end

function rndScale(scale, pos, string)
  if not scale or scale == "" then scale = modes[math.random(#modes)] end
  if not string or string == "" then string = "All" end
  if not pos then
    pos = getFret()
  else
    if type(pos) == "table" then
      pos = getFret(pos[1], pos[2])
    elseif type(tonumber(pos)) == "number" then
      pos = getFret(pos)
    end
  end
  return scale.." "..pos.." "..string
end

function rndRoot(filter)
  if not filter then filter = 1 end
  local out = ""
  if filter == "simple" or filter == "n" then
    while out == "" or string.match(out, "#") or string.match(out, "b") do
      out = root[math.random(#root)]
    end
  elseif filter == "#" or filter == "+b" then
    while out == "" and not string.match(out, "#") do
      out = root[math.random(#root)]
    end
  elseif filter == "b" or filter == "+#" then
    while out == "" and not string.match(out, "b") do
      out = root[math.random(#root)]
    end
  else
    out = root[math.random(#root)]
  end
  return out
end
