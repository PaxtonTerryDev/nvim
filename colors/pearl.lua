vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end
vim.g.colors_name = "arc"

local h = vim.api.nvim_set_hl

local none = "none"

local c = {
	yellow = "#CFAB4A",
	red = "#CF4A4A",
	green = "#4ACF9A",
	blue = "#4AA0CF",
}

local mono_color = {
	"#F5FAFA",
	"#EBE5CE",
	"#D4D0BA",
	"#BDBBA5",
	"#A5A591",
	"#8D8E7D",
	"#757768",
	"#5D6054",
	"#464940",
	"#2F312B",
}

local mono_color_2 = {
	"#F5FAFA",
	"#EBE5CE",
	"#D4D4BA",
	"#B8BDA5",
	"#9DA591",
	"#838E7D",
	"#6B7768",
	"#546055",
	"#404942",
	"#2B312E",
}

local bg_color = "#333319"

local function mono(priority)
	return mono_color_2[priority]
end

local default_props = {
	bg = none,
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

		if type(value[1]) == "number" then
			priority = value[1]
			overrides = value[2]
		elseif type(value[1]) == "table" then
			overrides = value[1]
		end

		apply_highlight(name, priority, overrides)
	end
end

local syntax = {
	Comment = { 8, { italic = true } },
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
	SpecialComment = { 4 },
	Debug = { 4 },
	Underlined = { 4, { underline = true } },
	Ignore = { 9 },
	Error = { 1, { bold = true } },
	Todo = { { fg = c.blue, bold = true } },
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
	Directory = { { fg = c.blue } },
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
	DiagnosticError = { { fg = c.red } },
	DiagnosticWarn = { { fg = c.yellow } },
	DiagnosticInfo = { { fg = c.blue } },
	DiagnosticHint = { 8 },
	DiagnosticUnderlineError = { { sp = c.red, undercurl = true } },
	DiagnosticUnderlineWarn = { { sp = c.yellow, undercurl = true } },
	DiagnosticUnderlineInfo = { { sp = c.blue, undercurl = true } },
	DiagnosticUnderlineHint = { 8, { undercurl = true } },
}

local lsp = {
	LspReferenceText = { { bg = mono(2), fg = bg_color } },
	LspReferenceRead = { { bg = mono(2), fg = bg_color } },
	LspReferenceWrite = { { bg = mono(2), fg = bg_color } },
}

local treesitter = {
	["@variable"] = { 1 },
	["@variable.builtin"] = { 1 },
	["@variable.parameter"] = { 2 },
	["@variable.parameter.builtin"] = { 2 },
	["@variable.member"] = { 1 },
	["@constant"] = { 1 },
	["@constant.builtin"] = { 1 },
	["@constant.macro"] = { 2 },
	["@module"] = { 3 },
	["@module.builtin"] = { 3 },
	["@label"] = { 3 },
	["@string"] = { 3 },
	["@string.documentation"] = { 5 },
	["@string.regexp"] = { 4 },
	["@string.escape"] = { 2 },
	["@string.special"] = { 4 },
	["@string.special.symbol"] = { 4 },
	["@string.special.url"] = { 4, { underline = true } },
	["@string.special.path"] = { 4 },
	["@character"] = { 3 },
	["@character.special"] = { 4 },
	["@boolean"] = { 1 },
	["@number"] = { 1 },
	["@number.float"] = { 1 },
	["@type"] = { 1 },
	["@type.builtin"] = { 1 },
	["@type.definition"] = { 1 },
	["@attribute"] = { 4 },
	["@attribute.builtin"] = { 4 },
	["@property"] = { 4 },
	["@function"] = { 1 },
	["@function.builtin"] = { 2 },
	["@function.call"] = {},
	["@function.macro"] = { 3 },
	["@function.method"] = { 2 },
	["@function.method.call"] = { 2 },
	["@constructor"] = { 2 },
	["@operator"] = { 5 },
	["@keyword"] = { 4 },
	["@keyword.coroutine"] = { 4 },
	["@keyword.function"] = { 4 },
	["@keyword.operator"] = { 2 },
	["@keyword.import"] = { 4 },
	["@keyword.type"] = { 4 },
	["@keyword.modifier"] = { 3 },
	["@keyword.repeat"] = { 2 },
	["@keyword.return"] = { 1 },
	["@keyword.debug"] = { 2 },
	["@keyword.exception"] = { 2 },
	["@keyword.conditional"] = { 2 },
	["@keyword.conditional.ternary"] = { 2 },
	["@keyword.directive"] = { 3 },
	["@keyword.directive.define"] = { 3 },
	["@punctuation"] = { 6 },
	["@punctuation.delimiter"] = { 6 },
	["@punctuation.bracket"] = { 6 },
	["@punctuation.special"] = { 5 },
	["@comment"] = { 8 },
	["@comment.documentation"] = { { fg = "#2D6242" } },
	["@comment.error"] = { 4, { bold = true } },
	["@comment.warning"] = { 3, { bold = true } },
	["@comment.todo"] = { 1, { bold = true } },
	["@comment.note"] = { 4 },
	["@markup.strong"] = { 4, { bold = true } },
	["@markup.italic"] = { 4, { italic = true } },
	["@markup.strikethrough"] = { 6, { strikethrough = true } },
	["@markup.underline"] = { 4, { underline = true } },
	["@markup.heading"] = { 1, { bold = true } },
	["@markup.heading.1"] = { 1, { bold = true } },
	["@markup.heading.2"] = { 2, { bold = true } },
	["@markup.heading.3"] = { 3, { bold = true } },
	["@markup.heading.4"] = { 4, { bold = true } },
	["@markup.heading.5"] = { 5, { bold = true } },
	["@markup.heading.6"] = { 6, { bold = true } },
	["@markup.quote"] = { 7 },
	["@markup.math"] = { 4 },
	["@markup.link"] = { 3, { underline = true } },
	["@markup.link.label"] = { 4 },
	["@markup.link.url"] = { 4, { underline = true } },
	["@markup.raw"] = { 4 },
	["@markup.raw.block"] = { 5 },
	["@markup.list"] = { 5 },
	["@markup.list.checked"] = { 5 },
	["@markup.list.unchecked"] = { 5 },
	["@diff.plus"] = { 2 },
	["@diff.minus"] = { 8 },
	["@diff.delta"] = { 4 },
	["@tag"] = { 3 },
	["@tag.builtin"] = { 3 },
	["@tag.attribute"] = { 4 },
	["@tag.delimiter"] = { 6 },
	["@none"] = {},
	["@conceal"] = { 7 },
	["@spell"] = {},
	["@nospell"] = {},
}

local flash = {
	FlashLabel = { { fg = bg_color, bg = c.yellow, bold = true } },
}
highlight_group(syntax)
highlight_group(editor)
highlight_group(diff)
highlight_group(git)
highlight_group(diagnostics)
highlight_group(lsp)
highlight_group(treesitter)
highlight_group(flash)
-- Mode-based statusline colors
local function set_statusline_mode()
	local mode = vim.fn.mode()

	if mode == "n" then
		-- Normal mode
		h(0, "StatusLine", { fg = mono(4), bg = bg_color })
	elseif mode == "i" then
		-- Insert mode
		h(0, "StatusLine", { fg = bg_color, bg = c.green, bold = true })
	elseif mode == "v" or mode == "V" or mode == "\22" then
		-- Visual mode (\22 is Ctrl-V for visual block)
		h(0, "StatusLine", { fg = bg_color, bg = mono(1), bold = true })
	elseif mode == "R" then
		-- Replace mode
		h(0, "StatusLine", { fg = bg_color, bg = c.red, bold = true })
	elseif mode == "c" then
		-- Command mode
		h(0, "StatusLine", { fg = bg_color, bg = c.yellow, bold = true })
	else
		-- Default
		h(0, "StatusLine", { fg = mono(4), bg = bg_color })
	end
end

-- Set initial statusline
set_statusline_mode()

-- Create autocommands to update on mode change
local augroup = vim.api.nvim_create_augroup("StatusLineMode", { clear = true })
vim.api.nvim_create_autocmd("ModeChanged", {
	group = augroup,
	pattern = "*",
	callback = set_statusline_mode,
})
