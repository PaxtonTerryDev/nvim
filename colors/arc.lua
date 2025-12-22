vim.cmd('highlight clear')
if vim.fn.exists('syntax_on') then
  vim.cmd('syntax reset')
end
vim.g.colors_name = 'arc'

local h = vim.api.nvim_set_hl

function scale_color(hex, index, darken_percent)
  -- Remove # if present
  hex = hex:gsub("#", "")

  -- Convert hex to RGB
  local r = tonumber(hex:sub(1, 2), 16)
  local g = tonumber(hex:sub(3, 4), 16)
  local b = tonumber(hex:sub(5, 6), 16)

  -- Calculate darkening factor based on index
  -- Index 1 = original color, higher index = darker
  local steps = index - 1

  -- Darkening factors (adjust these to match your desired progression)
  local darken_percent = 0.15 -- 15% darker per step

  -- Apply darkening
  for i = 1, steps do
    r = math.floor(r * (1 - darken_percent))
    g = math.floor(g * (1 - darken_percent))
    b = math.floor(b * (1 - darken_percent))
  end

  -- Ensure values stay in valid range
  r = math.max(0, math.min(255, r))
  g = math.max(0, math.min(255, g))
  b = math.max(0, math.min(255, b))

  -- Convert back to hex
  return string.format("#%02X%02X%02X", r, g, b)
end

local DARKEN_PERCENT = 0.8

function color(hex, index)
  return scale_color(hex, index, DARKEN_PERCENT)
end

local none = 'none'

local c = {
  obra = '#ebe5ce',
}

local defaultProps = {
  fg = color(c.obra, 1),
  bg = none
}

local function apply_overrides(opts)
  local props = vim.tbl_extend('force', {}, defaultProps, opts or {})
  return props
end

local function process_highlight_spec(spec)
  if not spec or (type(spec) == 'table' and #spec == 0 and next(spec) == nil) then
    return {}
  end

  if type(spec) == 'table' and type(spec[1]) == 'string' and type(spec[2]) == 'number' then
    local color_hex = spec[1]
    local priority = spec[2]
    local additional_opts = spec[3] or {}

    local base = { fg = color(color_hex, priority) }

    return vim.tbl_extend('force', base, additional_opts)
  end

  return spec
end

local function apply_highlight(name, spec)
  local opts = process_highlight_spec(spec)
  local merged_opts = apply_overrides(opts)
  h(0, name, merged_opts)
end

local function highlight_group(group)
  for name, options in pairs(group) do
    apply_highlight(name, options)
  end
end

local bool = true

local syntax = {
  Comment = {},
  Constant = {},
  String = {},
  Character = {},
  Number = {},
  Boolean = {},
  Float = {},
  Identifier = {},
  Function = {},
  Statement = {},
  Conditional = {},
  Repeat = {},
  Label = {},
  Operator = {},
  Keyword = {},
  Exception = {},
  PreProc = {},
  Include = {},
  Define = {},
  Macro = {},
  PreCondit = {},
  Type = {},
  StorageClass = {},
  Structure = {},
  Typedef = {},
  Special = {},
  SpecialChar = {},
  Tag = {},
  Delimiter = {},
  SpecialComment = {},
  Debug = {},
  Underlined = {},
  Ignore = {},
  Error = {},
  Todo = {},
}

local editor = {
  Normal = {},
  NormalFloat = {},
  FloatBorder = {},
  ColorColumn = {},
  Conceal = {},
  Cursor = {},
  CursorLine = {},
  CursorColumn = {},
  CursorLineNr = {},
  LineNr = { c.obra, 4 },
  SignColumn = {},
  Folded = {},
  FoldColumn = {},
  MatchParen = {},
  ModeMsg = {},
  MoreMsg = {},
  NonText = {},
  Pmenu = {},
  PmenuSel = {},
  PmenuSbar = {},
  PmenuThumb = {},
  Question = {},
  QuickFixLine = {},
  Search = {},
  IncSearch = {},
  SpecialKey = {},
  SpellBad = {},
  SpellCap = {},
  SpellLocal = {},
  SpellRare = {},
  StatusLine = {},
  StatusLineNC = {},
  TabLine = {},
  TabLineFill = {},
  TabLineSel = {},
  Title = {},
  Visual = {},
  VisualNOS = {},
  WarningMsg = {},
  WildMenu = {},
  WinSeparator = {},
  VertSplit = {},
}

local diff = {
  DiffAdd = {},
  DiffChange = {},
  DiffDelete = {},
  DiffText = {},
}

local git = {
  GitSignsAdd = {},
  GitSignsChange = {},
  GitSignsDelete = {},
}

local diagnostics = {
  DiagnosticError = {},
  DiagnosticWarn = {},
  DiagnosticInfo = {},
  DiagnosticHint = {},
  DiagnosticUnderlineError = {},
  DiagnosticUnderlineWarn = {},
  DiagnosticUnderlineInfo = {},
  DiagnosticUnderlineHint = {},
}

local lsp = {
  LspReferenceText = {},
  LspReferenceRead = {},
  LspReferenceWrite = {},
}

local treesitter = {
  ['@variable'] = {},
  ['@variable.builtin'] = {},
  ['@variable.parameter'] = {},
  ['@variable.parameter.builtin'] = {},
  ['@variable.member'] = {},
  ['@constant'] = {},
  ['@constant.builtin'] = {},
  ['@constant.macro'] = {},
  ['@module'] = {},
  ['@module.builtin'] = {},
  ['@label'] = {},
  ['@string'] = {},
  ['@string.documentation'] = {},
  ['@string.regexp'] = {},
  ['@string.escape'] = {},
  ['@string.special'] = {},
  ['@string.special.symbol'] = {},
  ['@string.special.url'] = {},
  ['@string.special.path'] = {},
  ['@character'] = {},
  ['@character.special'] = {},
  ['@boolean'] = {},
  ['@number'] = {},
  ['@number.float'] = {},
  ['@type'] = {},
  ['@type.builtin'] = {},
  ['@type.definition'] = {},
  ['@attribute'] = {},
  ['@attribute.builtin'] = {},
  ['@property'] = {},
  ['@function'] = {},
  ['@function.builtin'] = {},
  ['@function.call'] = {},
  ['@function.macro'] = {},
  ['@function.method'] = {},
  ['@function.method.call'] = {},
  ['@constructor'] = {},
  ['@operator'] = {},
  ['@keyword'] = {},
  ['@keyword.coroutine'] = {},
  ['@keyword.function'] = {},
  ['@keyword.operator'] = {},
  ['@keyword.import'] = {},
  ['@keyword.type'] = {},
  ['@keyword.modifier'] = {},
  ['@keyword.repeat'] = {},
  ['@keyword.return'] = {},
  ['@keyword.debug'] = {},
  ['@keyword.exception'] = {},
  ['@keyword.conditional'] = {},
  ['@keyword.conditional.ternary'] = {},
  ['@keyword.directive'] = {},
  ['@keyword.directive.define'] = {},
  ['@punctuation'] = {},
  ['@punctuation.delimiter'] = {},
  ['@punctuation.bracket'] = {},
  ['@punctuation.special'] = {},
  ['@comment'] = {},
  ['@comment.documentation'] = {},
  ['@comment.error'] = {},
  ['@comment.warning'] = {},
  ['@comment.todo'] = {},
  ['@comment.note'] = {},
  ['@markup.strong'] = {},
  ['@markup.italic'] = {},
  ['@markup.strikethrough'] = {},
  ['@markup.underline'] = {},
  ['@markup.heading'] = {},
  ['@markup.heading.1'] = {},
  ['@markup.heading.2'] = {},
  ['@markup.heading.3'] = {},
  ['@markup.heading.4'] = {},
  ['@markup.heading.5'] = {},
  ['@markup.heading.6'] = {},
  ['@markup.quote'] = {},
  ['@markup.math'] = {},
  ['@markup.link'] = {},
  ['@markup.link.label'] = {},
  ['@markup.link.url'] = {},
  ['@markup.raw'] = {},
  ['@markup.raw.block'] = {},
  ['@markup.list'] = {},
  ['@markup.list.checked'] = {},
  ['@markup.list.unchecked'] = {},
  ['@diff.plus'] = {},
  ['@diff.minus'] = {},
  ['@diff.delta'] = {},
  ['@tag'] = {},
  ['@tag.builtin'] = {},
  ['@tag.attribute'] = {},
  ['@tag.delimiter'] = {},
  ['@none'] = {},
  ['@conceal'] = {},
  ['@spell'] = {},
  ['@nospell'] = {},
}

highlight_group(syntax)
highlight_group(editor)
highlight_group(diff)
highlight_group(git)
highlight_group(diagnostics)
highlight_group(lsp)
highlight_group(treesitter)
