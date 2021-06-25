----- GLOBAL VARIABLES -----
local pseed = 0
local bseed = 0
local calibrationFrame = 0
local frame = -1
local adjustFrame = 0
local vframe = 0
local initial = 0
local apf = 0
local prevframe = 0
local trainer1 = 0
local tid = 0
local sid = 0
local name = ""
local pokemonindex = 0

--Add an underscore (_) to the beginning of the filename if you want the script to auto launch once you start a game!

function next(s)	
 local a=0x0003*(s%65536)+(s>>16)*0x43FD
 local b=0x43FD*(s%65536)+(a%65536)*65536+0x00269EC3
 local c=b%4294967296
 return c
end

function back(s)	
  local a=0xB9B3*(s%65536)+(s>>16)*0x3155
  local b=0x3155*(s%65536)+(a%65536)*65536+0xA170F641
  local c=b%4294967296
  return c
 end

function onScriptStart()

end

function onScriptCancel()
	SetScreenText("")
end

function onScriptUpdate()
  seed = ReadValue32(0x80478c90)

  if vframe ~= GetFrameCount() then
    vframe = GetFrameCount()
    prevframe = frame
    if vframe < 8 then
      initial = seed
      pseed = initial
    end
    if pseed ~= seed and bseed ~= seed then
      bseed = pseed
      calibrationFrame = 0
    end
    while pseed ~= seed and bseed ~= seed do
      pseed = next(pseed)
      bseed = back(bseed)
      calibrationFrame = calibrationFrame + 1
    end
    if calibrationFrame ~= 0 then
      if pseed == seed then
        frame = frame + calibrationFrame
        bseed = seed
      else
        frame = frame - calibrationFrame
        pseed = seed
      end
      calibrationFrame = 0
    end
    apf = frame-prevframe
    slot = 1 -- enemy pokemon slot
    pokemonindex = 0x8047306C + 0x138 * slot-1
    species = ReadValue16(pokemonindex)
    pid = ReadValue32(pokemonindex+0x4)
    hpiv = ReadValue16(pokemonindex+0xA4)
    atkiv = ReadValue16(pokemonindex+0xA6)
    defiv = ReadValue16(pokemonindex+0xA8)
    spaiv = ReadValue16(pokemonindex+0xAA)
    spdiv = ReadValue16(pokemonindex+0xAC)
    speiv = ReadValue16(pokemonindex+0xAE)

    local text = ""
	  text = text .. string.format("\nSeed: %08x\n", seed)
	  text = text .. string.format("RNG Frame: %d\n", frame)
	  text = text .. string.format("Initial: %08x\n", initial)
	  text = text .. string.format("VFrame: %d\n", vframe)
	  text = text .. string.format("APF: %d\n", apf)
	  text = text .. string.format("PID: %08x\n", pid)
	  text = text .. string.format("IVs: %d/%d/%d/%d/%d/%d\n", hpiv, atkiv, defiv, spaiv, spdiv, speiv)
    SetScreenText(text)
  end
end

function onStateLoaded()

end

function onStateSaved()

end
