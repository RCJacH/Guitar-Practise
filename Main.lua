-- Guitar Practise Software
local info = debug.getinfo(1,'S');
-- print(info.source:match("@(.*)$") )
package.path = ';?.lua;'..package.path
--package.cpath = package.cpath..";C:\\Users\\JacH\\Documents\\Tools\\IDE\\wxLua-2.8.12.3-Lua-5.1.5-MSW-Ansi\\bin\\?.dll;"
--require("wx")

require"Chord"
require"LeftHand"
require"Permutation"
require"Rhythms"
require"RightHand"
require"Technique"
require"Functions"
-- Variables ====>
local s_rhythm, s_perm, s_chord, s_scale, s_finger, s_tech
language = "English"
-- Names
if language == "English" then
  s_rhythm = "Rhythm"
  s_perm ="Permutation"
  s_chord = "Chord"
  s_scale = "Scale"
  s_finger = "Fingers"
  s_tech = "Technique"
end
-- Lists
local exercises = {s_rhythm, s_perm, s_chord, s_scale, s_finger, s_tech} 
-- Others
separator = " | "

-- <==== Variables
function main()
  local userInput, exit
  while not strComp(exit, "exit") do
    print("Select Functions: "..table.concat(exercises, ", "))
    userInput=io.read()
    if userInput == "" then userInput = exercises[math.random(#exercises)] end
    exit = selection(userInput)
  end
end

function selection(input)
  local exit, userSelection
  local lastInput = ""
  if strComp(input, s_rhythm) or exercises[tonumber(input)] == s_rhythm then
    print("Select Normal/Additive:")
    userSelection=io.read()
    if tonumber(userSelection) == 1 then
      exit = fRhythm()
    elseif tonumber(userSelection) == 2 then
      exit = fAddRhythm()
    end
  elseif strComp(input, s_perm) or strComp(input, "Perm") or exercises[tonumber(input)] == s_perm then
    print("Select Pattern/Variation:")
    userSelection=io.read()
    if tonumber(userSelection) == 1 then
      exit = fPerm()
    elseif tonumber(userSelection) == 2 then
      exit = fPermVary()
    end
  elseif strComp(input, s_chord) or exercises[tonumber(input)] == s_chord then
    exit = fChord()
  elseif strComp(input, s_scale) or exercises[tonumber(input)] == s_scale then
    exit = fScale()
  elseif strComp(input, s_finger) or exercises[tonumber(input)] == s_finger then
    print("Select Instrument: Piano/Guitar")
    userSelection=io.read()
    if userSelection == "1" or userSelection:match'ian' then
      exit = fFingers("Piano")
    elseif userSelection == "2" or userSelection:match'uit' then
      exit = fFingers("Guitar")
    end
  elseif strComp(input, s_tech) or strComp(input, "tech") or exercises[tonumber(input)] == s_tech then
    exit = fTechs()
  else
    return input
  end
  if exit then return "exit" else return end
end

function fRhythm()
  local lastInput, sel, first
  while true do
    if not first then
      print("Input number of Patterns, type of Pattern, seperated with a comma:")
      first = 1
    end
    io.flush()
    sel=io.read()
    if strComp(sel, "exit") then return true
    elseif strComp(sel, "back") then return
    elseif sel == "" then sel = lastInput end
    lastInput = sel
    local number, element = sel:match "(.-),(.-)"
    if not number then number = sel end
    if not element then element = "n" end
    print(RandomizeRhythm(tonumber(number), tostring(element), 2))
  end
end

function fAddRhythm()
  local lastInput, sel, first
  while true do
    if not first then print("Input total number:"); first = 1 end
    sel=io.read()
    if strComp(sel, "exit") then return true
    elseif strComp(sel, "back") then return
    elseif sel == "" then sel = lastInput end
    lastInput = sel
    print(getAdditive(tonumber(sel)))
  end
end

function fPerm()
  local first, sel
  while true do
    if not first then print("Input number of items to permutate:"); first = 1 end
    io.flush()
    sel=io.read()
    if strComp(sel, "exit") then return true
    elseif strComp(sel, "back") then return
    elseif sel == "" then sel = lastInput end
    lastInput = sel
    print(genPermutation(tonumber(sel)))
  end
end

function fPermVary()
  local first, sel, v2, v3, v4
  while true do
    local out = {}
    if not first then print("Input which interval to vary:"); first = 1 end
    io.flush()
    sel=io.read()
    if strComp(sel, "exit") then return true
    elseif strComp(sel, "back") then return
    elseif sel == "" then sel = lastInput end
    if sel == "1" then
      
    else
      if sel:match'2' then out[#out+1] = "Seconds: "..genPSeconds() end
      if sel:match'3' then out[#out+1] = "Thirds: "..genPThirds() end
      if sel:match'4' then out[#out+1] = "Fourths: "..genPFourths() end
    end
    lastInput = sel
    print(table.concat(out, separator))
  end
end
function fChord()
  local first, sel
  while true do
    if not first then print("Chords:"); first = 1 end
    print(rndRoot()..rndChord())
    io.flush()
    sel=io.read()
    if strComp(sel, "exit") then return true
    elseif strComp(sel, "back") then return end
  end
end

function fFingers(ins)
  local first, sel
  while true do
    if not first then
      if strComp(ins, "Guitar") then
        print("Left Hand Fingers:")
      elseif strComp(ins, "Piano") then
        print("Both Hand Fingers:")
      end
      first = 1
    end
    if strComp(ins, "Guitar") then
      print(getFingers(nil,"Guitar"))
    elseif strComp(ins, "Piano") then
      print(getFingers()..separator..getFingers())
    end
    sel=io.read()
    if strComp(sel, "exit") then return true
    elseif strComp(sel, "back") then return
    elseif sel == "" then sel = lastInput end
    lastInput = sel
  end
end

function fScale()
  local first, sel
  while true do
    if not first then print("Scales: Optional Scale, Position, String"); first = 1 end
    sel=io.read()
    if strComp(sel, "exit") then return true
    elseif strComp(sel, "back") then return
    elseif sel == "" then sel = lastInput
    elseif sel and sel ~= "" then
      local scale, pos, string = sel:match "(.-),(%d-),(.-)"
      print(rndRoot().." "..rndScale(scale, pos, string))
    else
      print(rndRoot().." "..rndScale())
    end
    lastInput = sel
  end
end

function fTechs()
  local first, sel
  while true do
    sel=io.read()
    if strComp(sel, "exit") then return true
    elseif strComp(sel, "back") then return
    else print(rndTech()) end
  end
end
--
main()