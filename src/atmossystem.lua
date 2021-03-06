local atmossystem = {}
local musiclist
local currentMusic


function atmossystem.load()
  local default = love.audio.newSource("assets/space4.mp3") -- bpm 140
  local alt = love.audio.newSource("assets/space5.mp3")
  musiclist = {
    alt, default
  }
  currentMusic = math.random(#musiclist)
  atmossystem.rotateMusic()

  atmossystem.bpm = 140
  atmossystem.timer = 0

  atmossystem.colortable = {}
end

function atmossystem.update(dt)
  atmossystem.colortable.r = 128*(1+(math.sin(love.timer.getTime())))
  atmossystem.colortable.g = 128*(1+(math.sin(2+love.timer.getTime())))
  atmossystem.colortable.b = 128*(1+(math.sin(4+love.timer.getTime())))
  atmossystem.timer = atmossystem.timer + dt

  love.graphics.setColor(atmossystem.colortable.r, atmossystem.colortable.g, atmossystem.colortable.b)

  if atmossystem.timer >= 60/atmossystem.bpm then
    atmossystem.timer = 0
    pulse = 1
  end

  pulse = math.max(pulse - 2*dt, 0)
end

function atmossystem.rotateMusic()
  currentMusic = (currentMusic % #musiclist) + 1

  if atmossystem.music then atmossystem.music:stop() end
  atmossystem.timer = 0
  pulse = 0

  atmossystem.music = musiclist[currentMusic]
  atmossystem.music:setLooping(true)
  atmossystem.music:setVolume(0.4)
  atmossystem.music:play()
end

return atmossystem
