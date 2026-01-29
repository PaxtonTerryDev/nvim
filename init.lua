function import(package)
  vim.pack.add({ { src = string.format("https://github.com/%s", package) } })
end

require("options")
require("lsp")
-- require("colorschemes.lackluster")
vim.cmd.colorscheme("pearl")
require("diagnostics")
require("plugins")
require("keymaps")

