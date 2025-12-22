vim.cmd('highlight clear')
if vim.fn.exists('syntax_on') then
  vim.cmd('syntax reset')
end
vim.g.colors_name = 'arc'

local h = vim.api.nvim_set_hl

local none = 'none'

local c = {
  obra = '#ebe5ce',
  luster = '#ffffff',
  gray = '#6A6759',
  yellow = '#cfab4a',
  blue = '#214F4B',
  red = '#ff0d1a',
  green = '#c2fe0b'
}

local mono_color = {
  '#F5FAFA',
  '#EBE5CE',
  '#D4D0BA',
  '#BDBBA5',
  '#A5A591',
  '#8D8E7D',
  '#757768',
  '#5D6054',
  '#464940',
  '#2F312B',
}

local mono_color_2 = {
  '#F5FAFA',
  '#EBE5CE',
  '#D4D4BA',
  '#B8BDA5',
  '#9DA591',
  '#838E7D',
  '#6B7768',
  '#546055',
  '#404942',
  '#2B312E',
}

local bg_color = '#333319'

local function mono(priority)
  return mono_color_2[priority]
end

local default_props = {
  bg = none
}

local function apply_overrides(overrides)
  local merged_opts = {}
  for key, val in pairs(default_props) do
    merged_opts[key] = val
  end
  if overrides then
    for key, val in pairs(overrides) do
      merged_opts[key] = val
    end
  end
  return merged_opts
end

local function apply_highlight(name, priority, options)
  local opts = apply_overrides(options)
  if priority then
    opts.fg = mono(priority)
  end
  h(0, name, opts)
end

local function highlight_group(group)
  for key, value in pairs(group) do
    local name = key
    local priority = nil
    local overrides = nil

    if type(value[1]) == 'number' then
      priority = value[1]
      overrides = value[2]
    elseif type(value[1]) == 'table' then
      overrides = value[1]
    end

    apply_highlight(name, priority, overrides)
  end
end

local syntax = {
  Comment = { 8 },
  Constant = { 1 },
  String = { 3 },
  Character = { 3 },
  Number = { 2 },
  Boolean = { 2 },
  Float = { 2 },
  Identifier = { 4 },
  Function = { 2 },
  Statement = { 2 },
  Conditional = { 2 },
  Repeat = { 2 },
  Label = { 3 },
  Operator = { 5 },
  Keyword = { 2 },
  Exception = { 2 },
  PreProc = { 3 },
  Include = { 3 },
  Define = { 3 },
  Macro = { 3 },
  PreCondit = { 3 },
  Type = { 3 },
  StorageClass = { 3 },
  Structure = { 3 },
  Typedef = { 3 },
  Special = { 4 },
  SpecialChar = { 4 },
  Tag = { 3 },
  Delimiter = { 6 },
  SpecialComment = { 7 },
  Debug = { 4 },
  Underlined = { 4, { underline = true } },
  Ignore = { 9 },
  Error = { 1, { bold = true } },
  Todo = { 1, { bold = true } },
}

local editor = {
  Normal = { 5 },
  NormalFloat = { 5 },
  FloatBorder = { 7 },
  ColorColumn = { 9, { bg = bg_color } },
  Conceal = { 7 },
  Cursor = { 1, { reverse = true } },
  CursorLine = { { bg = mono(2), fg = bg_color } },
  CursorColumn = { { bg = mono(2), fg = bg_color } },
  CursorLineNr = { 3, { bold = true } },
  LineNr = { 8 },
  SignColumn = { 7 },
  Folded = { 7, { bg = bg_color } },
  FoldColumn = { 7 },
  MatchParen = { 1, { bold = true } },
  ModeMsg = { 4 },
  MoreMsg = { 3 },
  NonText = { 8 },
  Pmenu = { 5, { bg = bg_color } },
  PmenuSel = { { bg = mono(2), fg = bg_color, bold = true } },
  PmenuSbar = { { bg = bg_color } },
  PmenuThumb = { { bg = bg_color } },
  Question = { 3 },
  QuickFixLine = { 2, { bold = true } },
  Search = { { bg = mono(2), fg = bg_color } },
  IncSearch = { { bg = mono(2), fg = bg_color, bold = true } },
  SpecialKey = { 7 },
  SpellBad = { 1, { undercurl = true } },
  SpellCap = { 3, { undercurl = true } },
  SpellLocal = { 4, { undercurl = true } },
  SpellRare = { 4, { undercurl = true } },
  StatusLine = { 4, { bg = bg_color } },
  StatusLineNC = { 7, { bg = bg_color } },
  TabLine = { 6, { bg = bg_color } },
  TabLineFill = { 8, { bg = bg_color } },
  TabLineSel = { { bg = mono(2), fg = bg_color, bold = true } },
  Title = { 2, { bold = true } },
  Visual = { { bg = mono(2), fg = bg_color } },
  VisualNOS = { { bg = mono(2), fg = bg_color } },
  WarningMsg = { 2, { bold = true } },
  WildMenu = { { bg = mono(2), fg = bg_color } },
  WinSeparator = { 8 },
  VertSplit = { 8 },
}

local diff = {
  DiffAdd = { 2, { bg = bg_color } },
  DiffChange = { 4, { bg = bg_color } },
  DiffDelete = { 8, { bg = bg_color } },
  DiffText = { { bg = mono(2), fg = bg_color, bold = true } },
}

local git = {
  GitSignsAdd = { 2 },
  GitSignsChange = { 4 },
  GitSignsDelete = { 8 },
}

local diagnostics = {
  DiagnosticError = { 1 },
  DiagnosticWarn = { 3 },
  DiagnosticInfo = { 5 },
  DiagnosticHint = { 6 },
  DiagnosticUnderlineError = { 1, { undercurl = true } },
  DiagnosticUnderlineWarn = { 3, { undercurl = true } },
  DiagnosticUnderlineInfo = { 5, { undercurl = true } },
  DiagnosticUnderlineHint = { 6, { undercurl = true } },
}

local lsp = {
  LspReferenceText = { { bg = mono(2), fg = bg_color } },
  LspReferenceRead = { { bg = mono(2), fg = bg_color } },
  LspReferenceWrite = { { bg = mono(2), fg = bg_color } },
}

local treesitter = {
  ['@variable'] = { 5 },
  ['@variable.builtin'] = { 3 },
  ['@variable.parameter'] = { 4 },
  ['@variable.parameter.builtin'] = { 3 },
  ['@variable.member'] = { 4 },
  ['@constant'] = { 1 },
  ['@constant.builtin'] = { 1 },
  ['@constant.macro'] = { 2 },
  ['@module'] = { 3 },
  ['@module.builtin'] = { 3 },
  ['@label'] = { 3 },
  ['@string'] = { 3 },
  ['@string.documentation'] = { 5 },
  ['@string.regexp'] = { 4 },
  ['@string.escape'] = { 2 },
  ['@string.special'] = { 4 },
  ['@string.special.symbol'] = { 4 },
  ['@string.special.url'] = { 4, { underline = true } },
  ['@string.special.path'] = { 4 },
  ['@character'] = { 3 },
  ['@character.special'] = { 4 },
  ['@boolean'] = { 2 },
  ['@number'] = { 2 },
  ['@number.float'] = { 2 },
  ['@type'] = { 3 },
  ['@type.builtin'] = { 3 },
  ['@type.definition'] = { 3 },
  ['@attribute'] = { 4 },
  ['@attribute.builtin'] = { 4 },
  ['@property'] = { 4 },
  ['@function'] = { 2 },
  ['@function.builtin'] = { 2 },
  ['@function.call'] = {},
  ['@function.macro'] = { 3 },
  ['@function.method'] = { 2 },
  ['@function.method.call'] = { 2 },
  ['@constructor'] = { 2 },
  ['@operator'] = { 5 },
  ['@keyword'] = { 2 },
  ['@keyword.coroutine'] = { 2 },
  ['@keyword.function'] = { 2 },
  ['@keyword.operator'] = { 2 },
  ['@keyword.import'] = { 2 },
  ['@keyword.type'] = { 2 },
  ['@keyword.modifier'] = { 3 },
  ['@keyword.repeat'] = { 2 },
  ['@keyword.return'] = { 2 },
  ['@keyword.debug'] = { 2 },
  ['@keyword.exception'] = { 2 },
  ['@keyword.conditional'] = { 2 },
  ['@keyword.conditional.ternary'] = { 2 },
  ['@keyword.directive'] = { 3 },
  ['@keyword.directive.define'] = { 3 },
  ['@punctuation'] = { 6 },
  ['@punctuation.delimiter'] = { 6 },
  ['@punctuation.bracket'] = { 6 },
  ['@punctuation.special'] = { 5 },
  ['@comment'] = { 8 },
  ['@comment.documentation'] = { 7 },
  ['@comment.error'] = { 1, { bold = true } },
  ['@comment.warning'] = { 3, { bold = true } },
  ['@comment.todo'] = { 1, { bold = true } },
  ['@comment.note'] = { 4 },
  ['@markup.strong'] = { 4, { bold = true } },
  ['@markup.italic'] = { 4, { italic = true } },
  ['@markup.strikethrough'] = { 6, { strikethrough = true } },
  ['@markup.underline'] = { 4, { underline = true } },
  ['@markup.heading'] = { 1, { bold = true } },
  ['@markup.heading.1'] = { 1, { bold = true } },
  ['@markup.heading.2'] = { 2, { bold = true } },
  ['@markup.heading.3'] = { 3, { bold = true } },
  ['@markup.heading.4'] = { 4, { bold = true } },
  ['@markup.heading.5'] = { 5, { bold = true } },
  ['@markup.heading.6'] = { 6, { bold = true } },
  ['@markup.quote'] = { 7 },
  ['@markup.math'] = { 4 },
  ['@markup.link'] = { 3, { underline = true } },
  ['@markup.link.label'] = { 4 },
  ['@markup.link.url'] = { 4, { underline = true } },
  ['@markup.raw'] = { 4 },
  ['@markup.raw.block'] = { 5 },
  ['@markup.list'] = { 5 },
  ['@markup.list.checked'] = { 5 },
  ['@markup.list.unchecked'] = { 5 },
  ['@diff.plus'] = { 2 },
  ['@diff.minus'] = { 8 },
  ['@diff.delta'] = { 4 },
  ['@tag'] = { 3 },
  ['@tag.builtin'] = { 3 },
  ['@tag.attribute'] = { 4 },
  ['@tag.delimiter'] = { 6 },
  ['@none'] = {},
  ['@conceal'] = { 7 },
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
