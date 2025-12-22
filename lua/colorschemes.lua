vim.pack.add({
  { src = "https://github.com/vague-theme/vague.nvim" },
  { src = "https://github.com/AlexvZyl/nordic.nvim" },
  { src = "https://github.com/wnkz/monoglow.nvim" },
})

-- ARCHIVE

-- require("vague").setup({
--   transparent = true
-- })
-- require("nordic").setup({
--   transparent = {
--     bg = true,
--     float = false
--   }
-- })
--
require("monoglow").setup({
  transparent = true,
  on_colors = function(colors)
    colors.glow = honeyBronze
  end
})
--
-- 
-- require("colorschemes")
-- 
-- vim.pack.add({
--   { src = "https://github.com/slugbyte/lackluster.nvim" },
-- })
-- 
-- local cl_teal = "#468189"
-- local cl_darkCyan = "#0F8B8D"
-- local cl_goldenGlow = "#DDD718"
-- local cl_honeyBronze = "#F6AE2D"
-- local cl_softPeriwinkle = "#8F8FC9"
-- local cl_evergreen = "#002E2C"
-- 
-- 
-- local lackluster = require("lackluster")
-- local color = lackluster.color
-- 
-- lackluster.setup({
--   -- tweak_syntax = {
--   --   string = color.green,
--   --   string_escape = color.luster,
--   --   comment = color.gray5,
--   --   builtin = "#611C35",
--   --   type = cl_evergreen,
--   --   keyword = color.lack,
--   --   keyword_return = color.red,
--   --   keyword_exception = "default",
--   -- },
--   tweak_syntax = {
--     comment = color.gray5,
--   },
--   tweak_background = {
--     normal = 'none',
--     telescope = 'none',
--     menu = lackluster.color.gray3,
--     popup = 'default',
--   },
--   tweak_color = {
--     lack = "default",
--     luster = "default",
--     orange = "default",
--     yellow = "default",
--     green = "default",
--     blue = "default",
--     red = "default",
-- 
--     -- Grayscale
-- 
--     black = cl_black,
--     gray1 = gray_1,
--     gray2 = gray_2,
--     gray3 = gray_3,
--     gray4 = gray_4,
--     gray5 = gray_5,
--     gray6 = gray_6,
--     gray7 = gray_7,
--     gray8 = gray_8,
--     gray9 = gray_9,
--   },
-- })
-- 
