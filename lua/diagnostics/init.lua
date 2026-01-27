vim.diagnostic.config({
  virtual_text = {
    spacing = 4,
    prefix = "●",
    -- Only show errors and warnings in virtual text (less clutter)
    severity = { min = vim.diagnostic.severity.WARN },
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
    wrap = true,    -- Wrap long lines in float
    max_width = 80, -- Set max width for readability
  },
})
