local M = {}

local function import_apply_colorscheme(path, name, setup_opts)
  import(path)

  if setup_opts ~= nil then
    require(name).setup(setup_opts)
  end

  vim.cmd.colorscheme(name)
end

function M.use(config)
  local opts = config[3] or nil
  import_apply_colorscheme(config[1], config[2], opts)
end

return M
