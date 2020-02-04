--[[
    Given a table of formatted text tables, render them vertically and horizontally centered
    The keys in the formatted text tables are:
    scale - DEFAULT: 1
    textColor - DEFAULT: COLORS['light']
    backgroundColor - DEFAULT: opposite of textColor
    string
  ]]
function RenderCenteredText(formattedText)
  local accumulated_height = 0
  
  -- calculate the accumulated height and populate the formatted text table with defaults if needed
  for k, line in pairs(formattedText) do
    line.scale = line.scale ~= nil and line.scale or 1
    line.accumulated_height = accumulated_height
    accumulated_height = accumulated_height + FONT_HEIGHT * line.scale
    line.textColor = line.textColor or COLORS['light']
    line.backgroundColor = line.backgroundColor or (
      line.textColor == COLORS['light'] and COLORS['dark'] or COLORS['light'])
  end
  
  local padding = (VIRTUAL_HEIGHT - accumulated_height) / 2
  
  love.graphics.clear(formattedText[1].backgroundColor)
  
  for k, line in pairs(formattedText) do
    love.graphics.setColor(line.textColor)
    if line.scale ~= 1 then
      love.graphics.push()
      love.graphics.scale(line.scale)
    end
    love.graphics.printf(line.string, 0, math.floor((padding + line.accumulated_height) / line.scale),
      math.floor(VIRTUAL_WIDTH / line.scale), 'center')
    if line.scale ~= 1 then
      love.graphics.pop()
    end
  end
end

--[[
    Given an "atlas" (a texture with multiple sprites), as well as a
    width and a height for the tiles therein, split the texture into
    all of the quads by simply dividing it evenly.
]]
function GenerateQuads(atlas, tilewidth, tileheight)
  local sheetWidth = atlas:getWidth() / tilewidth
  local sheetHeight = atlas:getHeight() / tileheight
  
  local spritesheet = {}
  
  for y = 0, sheetHeight - 1 do
    for x = 0, sheetWidth - 1 do
      table.insert(spritesheet, love.graphics.newQuad(x * tilewidth, y * tileheight,
          tilewidth, tileheight, atlas:getDimensions()))
    end
  end
  
  return spritesheet
end
