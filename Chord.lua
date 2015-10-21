-- Variables ====>
local nameMajor, nameMinor, nameDom, nameDim, nameAug = "maj", "m", "", "dim", "aug"
local chordFunc = {nameMajor, nameMinor, nameDom, nameDim, nameAug}
local chordExt = {"", "7","9","11","13"}
local chordVar = {"var5", "lyd", "sus", "var6", "var9", "alt"}
local varChance = 80
local var5Chance = 30
local var9Chance = 30
local var6Chance = 30
local varsusChance = 50
-- <=== Variables

require("Functions")
function rndChord(type)
  local func, ext, var, varstr, output
  if type and type ~= "" then
    if strComp(type, "major") or strComp(type, "maj") or strComp(type, "j") or type == "M" then
      func = chordFunc[1]
    elseif strComp(type, "minor") or strComp(type, "min") or type == "m" then
      func = chordFunc[2]
    elseif strComp(type, "dominant") or strComp(type, "dom") or strComp(type, "d") or type == "7" then
      func = chordFunc[3]
    elseif strComp(type, "diminished") or strComp(type, "dim") or strComp(type, "o") then
      func = chordFunc[4]
    elseif strComp(type, "augmented") or strComp(type, "aug") or type == "+" then
      func = chordFunc[5]
    end
  else
    math.random()
    if math.random(100) > 30 then func = chordFunc[math.random(#chordFunc-2)] else func = chordFunc[math.random(#chordFunc)] end
  end
  if func ~= nameDim and func ~= nameAug and math.random(100) < varChance then
    ext = chordExt[math.random(#chordExt)]
    if ext == "7" then
      while not varstr do
        var = chordVar[math.random(#chordVar)]
        if var ~= "alt" then
          if var == "var5" and func ~= nameMinor then
            varstr = var5()
          elseif var == "var9" and func ~= nameMinor then
            varstr = var9()
          elseif var == "sus" then
            varstr = varsus()
          elseif var == "lyd" and func ~= nameMinor then
            varstr = "#11"
          elseif var == "var6" then
            varstr = var6()
          end
        else
          if func == "" then varstr = var end
        end
      end
    elseif ext == "9" then
      while not varstr do
        var = chordVar[math.random(#chordVar)]
        if var == "var5" and func ~= nameMinor then
          varstr = var5()
        elseif var == "lyd" and func ~= nameMinor then
          varstr = "#11"
        elseif var == "var6" then
          varstr = var6()
        end
      end
    elseif ext == "11" then
      while not varstr do
        if math.random(100) < 50 and func ~= nameMinor then
          varstr = var5()
        else
          varstr = ""
        end
      end
    elseif ext == "13" then
      while not varstr do
        var = chordVar[math.random(#chordVar)]
        if var == "var5" and func ~= nameMinor then
          varstr = var5()
        elseif var == "var9" and func ~= nameMinor then
          varstr = var9()
        elseif var == "sus" then
          varstr = varsus()
        elseif var == "lyd" and func ~= nameMinor then
          varstr = "#11"
        end
      end
    else
      varstr = ""
    end
  else
    ext = ""
    varstr = ""
  end
  if func == nameMajor and (ext ~= "7" or ext ~= "9" or ext ~= "13") then
    func = ""
  end
  if varstr == "6" and func ~= "" then
    if ext == "9" then
      ext = "69"
      varstr = ""
    else
      ext = ""
    end
  end
  if string.match(varstr, "sus") then
    func = ""
  end
  output = func..ext..varstr
  return output
end

function var5()
  if math.random(100) < var5Chance then
    return ""
  else
    local var = {"b5", "#5"}
    return var[math.random(#var)]
  end
end

function var9()
  if math.random(100) < var9Chance then
    return ""
  else
    local var = {"b9", "", "#9"}
    return var[math.random(#var)]
  end
end

function varsus()
  if math.random(100) < varsusChance then
    return "sus4"
  else
    return "sus2"
  end
end

function var6()
  if math.random(100) < var6Chance then
    return "6"
  else
    return "b13"
  end
end