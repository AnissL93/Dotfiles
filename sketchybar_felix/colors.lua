-- return {
--   black = 0xff181926,
--   white = 0xffcad3f5,
--   red = 0xffed8796,
--   green = 0xffa6da95,
--   blue = 0xff8aadf4,
--   yellow = 0xffeed49f,
--   orange = 0xfff5a97f,
--   magenta = 0xffc6a0f6,
--   grey = 0xff939ab7,
--   cyan = 0xff94e2d5,
--   transparent = 0x00000000,
-- 
--   bar = {
--     bg = 0x801e1e2e,
--     border = 0xff2c2e34,
--   },
--   popup = {
--     bg = 0x801e1e2e,
--     border = 0xffcad3f5
--   },
--   bg1 = 0x801e1e2e,
--   bg2 = 0x80494d64,
-- 
--   with_alpha = function(color, alpha)
--     if alpha > 1.0 or alpha < 0.0 then return color end
--     return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
--   end,
-- }

-- return {
--   black = 0xff181926,          -- Deep dark tones, emphasizing the cyberpunk theme
--   white = 0xffcad3f5,          -- Soft, glowing white for neon effects
--   red = 0xffed8796,            -- Soft neon red
--   green = 0xffa6da95,          -- Neon green with a cool tone
--   blue = 0xff8aadf4,           -- Cool, bright blue, reminiscent of glowing holograms
--   yellow = 0xffeed49f,         -- Neon yellow with a slight orange tint
--   orange = 0xfff5a97f,         -- Neon orange for added vibrance
--   magenta = 0xffc6a0f6,        -- Magenta with a neon aesthetic
--   grey = 0xff939ab7,           -- Muted grey to balance out the brighter colors
--   cyan = 0xff94e2d5,           -- Cyan for a cool, futuristic look
--   transparent = 0x00000000,    -- Fully transparent for blending effects

--   bar = {
--     bg = 0x801e1e2e,           -- Dark background for bars
--     border = 0xff2c2e34,       -- Light border to emphasize edges
--   },
--   popup = {
--     bg = 0x801e1e2e,           -- Dark popup background
--     border = 0xffcad3f5        -- Light border for the popup
--   },
--   bg1 = 0x801e1e2e,            -- Dark background, perfect for the cyberpunk aesthetic
--   bg2 = 0x80494d64,            -- Slightly lighter dark background for contrast

--   with_alpha = function(color, alpha)
--     if alpha > 1.0 or alpha < 0.0 then return color end
--     return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
--   end,
-- }

-- return {
--   -- black = 0xff0d0d19,    -- Deep dark blue-black
--   -- white = 0xffd6e2ff,    -- Neon cool white
--   -- red = 0xffff3377,      -- Bright neon red
--   -- green = 0xff00ff99,    -- Fluorescent green
--   -- blue = 0xff0088ff,     -- Electric blue
--   -- yellow = 0xffffdd55,   -- Cyberpunk yellow
--   -- orange = 0xffff6622,   -- Glowing orange
--   -- magenta = 0xffcc00ff,  -- Intense neon magenta
--   -- grey = 0xff6c7387,     -- Muted cyberpunk grey
--   -- cyan = 0xff00e6e6,     -- Vibrant cyan
--   -- transparent = 0x00000000,

--   black   = 0xff123e7c,    -- Deep blue-black
--   white   = 0xffd7d7d5,    -- Light gray
--   red     = 0xffff0000,    -- Neon red
--   green   = 0xffd300c4,    -- Neon purple-green
--   yellow  = 0xfff57800,    -- Bright orange-yellow
--   blue    = 0xff123e7c,    -- Deep blue (same as black for contrast)
--   -- orange = 0xffff6622,   -- Glowing orange
--   magenta = 0xff711c91,    -- Deep magenta
--   -- grey = 0xff6c7387,     -- Muted cyberpunk grey
--   -- gray = 0x00B0B900,
--   orange  = 0xffff7f00,    -- Neon orange
-- grey    = 0xff808080,    -- Classic neutral gray
--   cyan    = 0xff0abdc6,    -- Bright cyan-blue
--   transparent = 0x00000000, -- Fully transparent

--   bar = {
--     bg = 0x80202030,     -- Semi-transparent dark
--     border = 0xff303040, -- Muted border
--   },
--   popup = {
--     bg = 0x80202030,     -- Same as bar background
--     border = 0xffd6e2ff  -- Neon white border
--   },
--   -- bg1 = 0x80202030,      -- Primary background
--   -- bg2 = 0x80404060,      -- Slightly lighter background

--   bg1 = 0x80000b1e,        -- Dark cyberpunk background
--   bg2 = 0x80494d64,        -- Slightly lighter dark background for contrast
--   with_alpha = function(color, alpha)
--     if alpha > 1.0 or alpha < 0.0 then return color end
--     return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
--   end,
-- }

-- return {
--   black = 0xff101820,          -- Darker, deeper black with a subtle teal tint
--   white = 0xffd0f0e0,          -- Softer white with a slight greenish glow
--   red = 0xffd94f5d,            -- A deeper, more muted red to avoid overpowering the green
--   green = 0xff79f299,          -- Bright, neon green with a cool futuristic tone
--   blue = 0xff5ad0f7,           -- Cyan-leaning blue to complement the green
--   yellow = 0xffd8f57f,         -- Muted yellow with a greenish hue
--   orange = 0xffe0a85f,         -- Slightly desaturated orange to blend with the theme
--   magenta = 0xffb073f6,        -- Soft neon magenta with less dominance
--   grey = 0xff6c7f92,           -- Darker grey with a cool tint
--   cyan = 0xff7ef4d8,           -- More prominent neon cyan-green
--   transparent = 0x00000000,    -- Fully transparent

--   bar = {
--     bg = 0x80141e1e,           -- Dark greenish-black background for bars
--     border = 0xff1b2e2c,       -- Deep green-tinted border
--   },
--   popup = {
--     bg = 0x80141e1e,           -- Dark pop-up background
--     border = 0xff79f299        -- Neon green glow border
--   },
--   bg1 = 0x80141e1e,            -- Deep green-black for the main background
--   bg2 = 0x80402f48,            -- A slightly lighter variant with a green tint

--   with_alpha = function(color, alpha)
--     if alpha > 1.0 or alpha < 0.0 then return color end
--     return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
--   end,
-- }


return {
  black   = 0xffd300c4,    -- Deep blue-black
  white   = 0xff00ff00,    -- Light gray
  red     = 0xffff0000,    -- Neon red
  green   = 0xffd300c4,    -- Neon purple-green
  yellow  = 0xfff57800,    -- Bright orange-yellow
  blue    = 0xff0abdc6,    -- Deep blue (same as black for contrast)
  magenta = 0xff711c91,    -- Deep magenta
  cyan    = 0xff0abdc6,    -- Bright cyan-blue
  transparent = 0x00000000, -- Fully transparent
  orange  = 0xffff7f00,    -- Neon orange
  grey    = 0xff808080,    -- Classic neutral gray

  bar = {
    bg = 0x80000b1e,       -- Dark greenish-black background for bars
    border = 0xffff0000,   -- Neon cyan-blue border for emphasis
  },
  popup = {
    bg = 0x80d300c4,       -- Dark background for popups
    border = 0xffd300c4,   -- Neon cyan-blue border
  },
  bg1 = 0x80000b1e,        -- Dark cyberpunk background
  bg2 = 0x80494d64,        -- Slightly lighter dark background for contrast

  with_alpha = function(color, alpha)
    if alpha > 1.0 or alpha < 0.0 then return color end
    return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
  end,
}
