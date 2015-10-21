local tech = {"Alternate Picking", "CrossString Picking", "Slides", "HO/PO", "Bend", "Turns", "Barring"}

function rndTech()
  return tech[math.random(#tech)]
end
