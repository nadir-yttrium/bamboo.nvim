local c = require('bamboo.colors')
local cfg = vim.g.bamboo_config
local util = require('bamboo.util')

local M = {}
local hl = { langs = {}, plugins = {} }

local function vim_highlights_nvim070(highlights)
  for group_name, group_settings in pairs(highlights) do
    local settings = {
      fg = group_settings.fg or 'none',
      bg = group_settings.bg or 'none',
      sp = group_settings.sp or 'none',
    }
    if group_settings.fmt and group_settings.fmt ~= 'none' then
      for _, setting in pairs(vim.split(group_settings.fmt, ',')) do
        settings[setting] = 1
      end
    end
    vim.api.nvim_set_hl(0, group_name, settings)
  end
end

local function vim_highlights_prior_to_nvim070(highlights)
  for group_name, group_settings in pairs(highlights) do
    vim.api.nvim_command(string.format(
      'highlight %s guifg=%s guibg=%s guisp=%s gui=%s', group_name,
      group_settings.fg or 'none',
      group_settings.bg or 'none',
      group_settings.sp or 'none',
      group_settings.fmt or 'none'))
  end
end

local vim_highlights = vim_highlights_prior_to_nvim070
if vim.fn.has('nvim-0.7.0') then
  vim_highlights = vim_highlights_nvim070
end

local colors = {
  Fg = { fg = c.fg },
  LightGrey = { fg = c.light_grey },
  Grey = { fg = c.grey },
  Red = { fg = c.red },
  Cyan = { fg = c.cyan },
  Yellow = { fg = c.yellow },
  Orange = { fg = c.orange },
  Green = { fg = c.green },
  Blue = { fg = c.blue },
  Purple = { fg = c.purple },
}
hl.common = {
  Normal = { fg = c.fg, bg = cfg.transparent and c.none or c.bg0 },
  Terminal = { fg = c.fg, bg = cfg.transparent and c.none or c.bg0 },
  EndOfBuffer = {
    fg = cfg.ending_tildes and c.bg2 or c.bg0,
    bg = cfg.transparent and c.none or c.bg0,
  },
  FoldColumn = { fg = c.fg, bg = cfg.transparent and c.none or c.bg0 },
  Folded = { fg = c.fg, bg = cfg.transparent and c.none or c.bg1 },
  SignColumn = { fg = c.fg, bg = cfg.transparent and c.none or c.bg0 },
  ToolbarLine = { fg = c.fg },
  Cursor = { fmt = 'reverse' },
  vCursor = { fmt = 'reverse' },
  iCursor = { fmt = 'reverse' },
  lCursor = { fmt = 'reverse' },
  CursorIM = { fmt = 'reverse' },
  CursorColumn = { bg = c.bg1 },
  CursorLine = { bg = c.bg1 },
  ColorColumn = { bg = c.bg1 },
  CursorLineNr = { fg = c.fg },
  LineNr = { fg = c.grey },
  Conceal = { fg = c.grey, bg = c.bg1 },
  DiffAdd = { fg = c.none, bg = c.diff_add },
  DiffChange = { fg = c.none, bg = c.diff_change },
  DiffDelete = { fg = c.none, bg = c.diff_delete },
  DiffText = { fg = c.none, bg = c.diff_text },
  DiffAdded = colors.Green,
  DiffRemoved = colors.Red,
  DiffFile = colors.Cyan,
  DiffIndexLine = colors.Grey,
  Directory = { fg = c.blue },
  ErrorMsg = { fg = c.red, fmt = 'bold' },
  WarningMsg = { fg = c.yellow, fmt = 'bold' },
  MoreMsg = { fg = c.blue, fmt = 'bold' },
  CurSearch = { fg = c.bg0, bg = c.orange },
  IncSearch = { fg = c.bg0, bg = c.orange },
  Search = { fg = c.bg0, bg = c.bg_yellow },
  Substitute = { fg = c.bg0, bg = c.green },
  MatchParen = { fg = c.orange, bg = c.grey, fmt = 'bold' },
  NonText = { fg = c.grey },
  Whitespace = { fg = c.grey },
  SpecialKey = { fg = c.grey },
  Pmenu = { fg = c.fg, bg = c.bg1 },
  PmenuSbar = { fg = c.none, bg = c.bg1 },
  PmenuSel = { fg = c.bg0, bg = c.bg_blue },
  WildMenu = { fg = c.bg0, bg = c.blue },
  PmenuThumb = { fg = c.none, bg = c.grey },
  Question = { fg = c.yellow },
  SpellBad = { fg = c.red, fmt = 'underline', sp = c.red },
  SpellCap = { fg = c.yellow, fmt = 'underline', sp = c.yellow },
  SpellLocal = { fg = c.blue, fmt = 'underline', sp = c.blue },
  SpellRare = { fg = c.purple, fmt = 'underline', sp = c.purple },
  StatusLine = { fg = c.fg, bg = c.bg2 },
  StatusLineTerm = { fg = c.fg, bg = c.bg2 },
  StatusLineNC = { fg = c.grey, bg = c.bg1 },
  StatusLineTermNC = { fg = c.grey, bg = c.bg1 },
  TabLine = { fg = c.fg, bg = c.bg1 },
  TabLineFill = { fg = c.grey, bg = c.bg1 },
  TabLineSel = { fg = c.bg0, bg = c.fg },
  VertSplit = { fg = c.bg3 },
  Visual = { bg = c.bg3 },
  VisualNOS = { fg = c.none, bg = c.bg2, fmt = 'underline' },
  QuickFixLine = { fg = c.blue, fmt = 'underline' },
  Debug = { fg = c.yellow },
  debugPC = { fg = c.bg0, bg = c.green },
  debugBreakpoint = { fg = c.bg0, bg = c.red },
  ToolbarButton = { fg = c.bg0, bg = c.bg_blue },
  FloatBorder = { fg = c.purple, bg = c.bg0 },
  NormalFloat = { fg = c.fg, bg = c.bg0 },
}

hl.syntax = {
  String = { fg = c.green, fmt = cfg.code_style.strings },
  Character = colors.Orange,
  Number = colors.Orange,
  Float = colors.Orange,
  Boolean = colors.Orange,
  Type = colors.Yellow,
  Structure = colors.Yellow,
  StorageClass = colors.Yellow,
  Identifier = { fg = c.red, fmt = cfg.code_style.variables },
  Constant = colors.Cyan,
  PreProc = colors.Purple,
  PreCondit = colors.Purple,
  Include = colors.Purple,
  Keyword = { fg = c.purple, fmt = cfg.code_style.keywords },
  Define = colors.Purple,
  Typedef = colors.Purple,
  Exception = colors.Purple,
  Conditional = { fg = c.purple, fmt = cfg.code_style.keywords },
  Repeat = { fg = c.purple, fmt = cfg.code_style.keywords },
  Statement = colors.Purple,
  Macro = colors.Red,
  Error = colors.Purple,
  Label = colors.Purple,
  Special = colors.Red,
  SpecialChar = colors.Red,
  Function = { fg = c.blue, fmt = cfg.code_style.functions },
  Operator = colors.Purple,
  Title = colors.Cyan,
  Tag = colors.Green,
  Delimiter = colors.LightGrey,
  Comment = { fg = c.grey, fmt = cfg.code_style.comments },
  SpecialComment = { fg = c.grey, fmt = cfg.code_style.comments },
  Todo = { fg = c.red, fmt = cfg.code_style.comments },
}

if vim.api.nvim_call_function('has', { 'nvim-0.8' }) == 1 then
  hl.treesitter = {
    ['@annotation'] = colors.Fg,
    ['@attribute'] = colors.Cyan,
    ['@boolean'] = colors.Orange,
    ['@character'] = colors.Orange,
    ['@comment'] = { fg = c.bg_yellow, fmt = cfg.code_style.comments },
    ['@conditional'] = { fg = c.purple, fmt = 'italic' },
    ['@constant'] = colors.Orange,
    ['@constant.builtin'] = colors.Orange,
    ['@constant.macro'] = colors.Orange,
    ['@constructor'] = { fg = c.yellow, fmt = 'bold' },
    ['@constructor.lua'] = { fg = c.yellow, fmt = 'none' },
    ['@error'] = colors.Fg,
    ['@exception'] = colors.Purple,
    ['@field'] = colors.Cyan,
    ['@float'] = colors.Orange,
    ['@function'] = { fg = c.blue, fmt = cfg.code_style.functions },
    ['@function.builtin'] = { fg = c.orange, fmt = cfg.code_style.functions },
    ['@function.macro'] = { fg = c.cyan, fmt = cfg.code_style.functions },
    ['@include'] = colors.Purple,
    ['@keyword'] = { fg = c.purple, fmt = cfg.code_style.keywords },
    ['@keyword.function'] = { fg = c.purple, fmt = cfg.code_style.functions },
    ['@keyword.operator'] = { fg = c.purple, fmt = cfg.code_style.keywords },
    ['@label'] = colors.Red,
    ['@method'] = colors.Blue,
    ['@namespace'] = colors.Yellow,
    ['@none'] = colors.Fg,
    ['@number'] = colors.Orange,
    ['@operator'] = { fg = util.lighten(c.purple, 0.5) },
    ['@parameter'] = { fg = c.red, fmt = 'italic' },
    ['@parameter.reference'] = colors.Fg,
    ['@property'] = colors.Cyan,
    ['@punctuation.delimiter'] = colors.LightGrey,
    ['@punctuation.bracket'] = colors.LightGrey,
    ['@punctuation.special'] = colors.Red,
    ['@repeat'] = { fg = c.purple, fmt = cfg.code_style.keywords },
    ['@string'] = { fg = c.green, fmt = cfg.code_style.strings },
    ['@string.regex'] = { fg = c.orange, fmt = cfg.code_style.strings },
    ['@string.escape'] = { fg = c.red, fmt = cfg.code_style.strings },
    ['@symbol'] = colors.Cyan,
    ['@tag'] = colors.Purple,
    ['@tag.attribute'] = colors.Yellow,
    ['@tag.delimiter'] = colors.Purple,
    ['@text'] = colors.Fg,
    ['@text.strong'] = { fg = c.fg, fmt = 'bold' },
    ['@text.emphasis'] = { fg = c.fg, fmt = 'italic' },
    ['@text.underline'] = { fg = c.fg, fmt = 'underline' },
    ['@text.strike'] = { fg = c.fg, fmt = 'strikethrough' },
    ['@text.title'] = { fg = c.orange, fmt = 'bold' },
    ['@text.title.1.markdown'] = { fg = c.red, fmt = 'bold' },
    ['@text.title.2.markdown'] = { fg = c.yellow, fmt = 'bold' },
    ['@text.title.3.markdown'] = { fg = c.green, fmt = 'bold' },
    ['@text.title.4.markdown'] = { fg = c.cyan, fmt = 'bold' },
    ['@text.title.5.markdown'] = { fg = c.blue, fmt = 'bold' },
    ['@text.title.6.markdown'] = { fg = c.purple, fmt = 'bold' },
    ['@text.literal'] = colors.Green,
    ['@none.markdown'] = {},
    ['@text.uri'] = { fg = c.cyan, fmt = 'underline' },
    ['@text.todo'] = { fg = c.black, bg = c.purple },
    ['@text.note'] = { fg = c.black, bg = c.blue },
    ['@text.danger'] = { fg = c.black, bg = c.red },
    ['@text.warning'] = { fg = c.black, bg = c.orange },
    ['@text.math'] = colors.Blue,
    ['@text.reference'] = colors.Blue,
    ['@text.environment'] = colors.Fg,
    ['@text.environment.name'] = colors.Fg,
    ['@text.diff.add'] = colors.Green,
    ['@text.diff.delete'] = colors.Red,
    ['@text.strong.markdown_inline'] = { fg = c.purple, fmt = 'bold' },
    ['@text.emphasis.markdown_inline'] = { fg = c.purple, fmt = 'italic' },
    ['@note'] = colors.Fg,
    ['@warning'] = colors.Fg,
    ['@danger'] = colors.Fg,
    ['@type'] = colors.Yellow,
    ['@type.builtin'] = colors.Orange,
    ['@variable'] = { fg = c.fg, fmt = cfg.code_style.variables },
    ['@variable.builtin'] = { fg = c.red, fmt = cfg.code_style.variables },
    ['@variable.global'] = { fg = util.lighten(c.red, 0.5), fmt = cfg
        .code_style.variables, },
    ['@variable.static'] = { fg = util.lighten(c.orange, 0.5), fmt = cfg
        .code_style.variables, },
  }
  if vim.api.nvim_call_function('has', { 'nvim-0.9' }) == 1 then
    hl.lsp = {
      ['@lsp.type.comment'] = {},
      ['@lsp.type.enum'] = { link = '@type' },
      ['@lsp.type.enumMember'] = { link = '@constant.builtin' },
      ['@lsp.type.interface'] = { link = '@type' },
      ['@lsp.type.typeParameter'] = { link = '@type' },
      ['@lsp.type.keyword'] = { link = '@keyword' },
      ['@lsp.type.namespace'] = { link = '@namespace' },
      ['@lsp.type.parameter'] = { link = '@parameter' },
      ['@lsp.type.property'] = { link = '@property' },
      ['@lsp.type.variable'] = { link = '@variable' },
      ['@lsp.type.macro'] = { link = '@function.macro' },
      ['@lsp.type.method'] = { link = '@method' },
      ['@lsp.type.number'] = { link = '@number' },
      ['@lsp.type.generic'] = { link = '@text' },
      ['@lsp.type.builtinType'] = { link = '@type.builtin' },
      ['@lsp.typemod.class.defaultLibrary'] = { link = '@type.builtin' },
      ['@lsp.typemod.enum.defaultLibrary'] = { link = '@type.builtin' },
      ['@lsp.typemod.enumMember.defaultLibrary'] = { link = '@constant.builtin' },
      ['@lsp.mod.readonly'] = { link = '@constant' },
      ['@lsp.mod.typeHint'] = { link = '@type' },
      ['@lsp.type.builtinConstant'] = { link = '@constant.builtin' },
      ['@lsp.typemod.method.defaultLibrary'] = { link = '@function.builtin' },
      ['@lsp.typemod.function.defaultLibrary'] = { link = '@function.builtin' },
      ['@lsp.typemod.macro.defaultLibrary'] = { link = '@function.builtin' },
      ['@lsp.type.magicFunction'] = { link = '@function.builtin' },
      ['@lsp.typemod.operator.injected'] = { link = '@operator' },
      ['@lsp.typemod.string.injected'] = { link = '@string' },
      ['@lsp.typemod.variable.defaultLibrary'] = { link = '@variable.builtin' },
      ['@lsp.typemod.variable.injected'] = { link = '@variable' },
      ['@lsp.typemod.variable.global'] = { link = '@variable.global' },
      -- these are specific to clangd: globalScope is buggy with `cout` so not used for now
      -- ['@lsp.typemod.variable.globalScope'] = { link = '@variable.global' },
      ['@lsp.typemod.variable.fileScope'] = { link = '@variable.static' },
    }
  end
else
  hl.treesitter = {
    TSAnnotation = colors.Fg,
    TSAttribute = colors.Cyan,
    TSBoolean = colors.Orange,
    TSCharacter = colors.Orange,
    TSComment = { fg = c.bg_yellow, fmt = cfg.code_style.comments },
    TSConditional = { fg = c.purple, fmt = cfg.code_style.keywords },
    TSConstant = colors.Orange,
    TSConstBuiltin = colors.Orange,
    TSConstMacro = colors.Orange,
    TSConstructor = { fg = c.yellow, fmt = 'bold' },
    TSError = colors.Fg,
    TSException = colors.Purple,
    TSField = colors.Cyan,
    TSFloat = colors.Orange,
    TSFunction = { fg = c.blue, fmt = cfg.code_style.functions },
    TSFuncBuiltin = { fg = c.cyan, fmt = cfg.code_style.functions },
    TSFuncMacro = { fg = c.cyan, fmt = cfg.code_style.functions },
    TSInclude = colors.Purple,
    TSKeyword = { fg = c.purple, fmt = cfg.code_style.keywords },
    TSKeywordFunction = { fg = c.purple, fmt = cfg.code_style.functions },
    TSKeywordOperator = { fg = c.purple, fmt = cfg.code_style.keywords },
    TSLabel = colors.Red,
    TSMethod = colors.Blue,
    TSNamespace = colors.Yellow,
    TSNone = colors.Fg,
    TSNumber = colors.Orange,
    TSOperator = { fg = util.lighten(c.purple, 0.5) },
    TSParameter = colors.Red,
    TSParameterReference = colors.Fg,
    TSProperty = colors.Cyan,
    TSPunctDelimiter = colors.LightGrey,
    TSPunctBracket = colors.LightGrey,
    TSPunctSpecial = colors.Red,
    TSRepeat = { fg = c.purple, fmt = cfg.code_style.keywords },
    TSString = { fg = c.green, fmt = cfg.code_style.strings },
    TSStringRegex = { fg = c.orange, fmt = cfg.code_style.strings },
    TSStringEscape = { fg = c.red, fmt = cfg.code_style.strings },
    TSSymbol = colors.Cyan,
    TSTag = colors.Purple,
    TSTagDelimiter = colors.Purple,
    TSText = colors.Fg,
    TSStrong = { fg = c.fg, fmt = 'bold' },
    TSEmphasis = { fg = c.fg, fmt = 'italic' },
    TSUnderline = { fg = c.fg, fmt = 'underline' },
    TSStrike = { fg = c.fg, fmt = 'strikethrough' },
    TSTitle = { fg = c.orange, fmt = 'bold' },
    TSLiteral = colors.Green,
    TSURI = { fg = c.cyan, fmt = 'underline' },
    TSMath = colors.Fg,
    TSTextReference = colors.Blue,
    TSEnvironment = colors.Fg,
    TSEnvironmentName = colors.Fg,
    TSNote = colors.Fg,
    TSWarning = colors.Fg,
    TSDanger = colors.Fg,
    TSType = colors.Yellow,
    TSTypeBuiltin = colors.Orange,
    TSVariable = { fg = c.fg, fmt = cfg.code_style.variables },
    TSVariableBuiltin = { fg = c.red, fmt = cfg.code_style.variables },
  }
end

local diagnostics_error_color = cfg.diagnostics.darker and c.dark_red or c.red
local diagnostics_hint_color = cfg.diagnostics.darker and c.dark_purple or
    c.purple
local diagnostics_warn_color = cfg.diagnostics.darker and c.dark_yellow or
    c.yellow
local diagnostics_info_color = cfg.diagnostics.darker and c.dark_cyan or c.cyan
hl.plugins.lsp = {
  LspCxxHlGroupEnumConstant = colors.Orange,
  LspCxxHlGroupMemberVariable = colors.Orange,
  LspCxxHlGroupNamespace = colors.Blue,
  LspCxxHlSkippedRegion = colors.Grey,
  LspCxxHlSkippedRegionBeginEnd = colors.Red,

  DiagnosticUnnecessary = { fg = c.grey, fmt = cfg.code_style.comments },
  DiagnosticError = { fg = c.red },
  DiagnosticHint = { fg = c.purple },
  DiagnosticInfo = { fg = c.cyan },
  DiagnosticWarn = { fg = c.yellow },

  DiagnosticVirtualTextError = {
    bg = cfg.diagnostics.background and
        util.darken(diagnostics_error_color, 0.1, c.bg0) or c.none,
    fg = diagnostics_error_color,
  },
  DiagnosticVirtualTextWarn = {
    bg = cfg.diagnostics.background and
        util.darken(diagnostics_warn_color, 0.1, c.bg0) or c.none,
    fg = diagnostics_warn_color,
  },
  DiagnosticVirtualTextInfo = {
    bg = cfg.diagnostics.background and
        util.darken(diagnostics_info_color, 0.1, c.bg0) or c.none,
    fg = diagnostics_info_color,
  },
  DiagnosticVirtualTextHint = {
    bg = cfg.diagnostics.background and
        util.darken(diagnostics_hint_color, 0.1, c.bg0) or c.none,
    fg = diagnostics_hint_color,
  },

  DiagnosticUnderlineError = {
    fmt = cfg.diagnostics.undercurl and 'undercurl' or 'underline', sp = c.red },
  DiagnosticUnderlineHint = {
    fmt = cfg.diagnostics.undercurl and 'undercurl' or 'underline',
    sp = c
        .purple,
  },
  DiagnosticUnderlineInfo = {
    fmt = cfg.diagnostics.undercurl and 'undercurl' or 'underline', sp = c.blue },
  DiagnosticUnderlineWarn = {
    fmt = cfg.diagnostics.undercurl and 'undercurl' or 'underline',
    sp = c
        .yellow,
  },

  LspReferenceText = { bg = c.bg2 },
  LspReferenceWrite = { bg = c.bg2 },
  LspReferenceRead = { bg = c.bg2 },

  LspCodeLens = { fg = c.grey, fmt = cfg.code_style.comments },
  LspCodeLensSeparator = { fg = c.grey },
}

hl.plugins.lsp.LspDiagnosticsDefaultError = hl.plugins.lsp.DiagnosticError
hl.plugins.lsp.LspDiagnosticsDefaultHint = hl.plugins.lsp.DiagnosticHint
hl.plugins.lsp.LspDiagnosticsDefaultInformation = hl.plugins.lsp.DiagnosticInfo
hl.plugins.lsp.LspDiagnosticsDefaultWarning = hl.plugins.lsp.DiagnosticWarn
hl.plugins.lsp.LspDiagnosticsUnderlineError = hl.plugins.lsp
    .DiagnosticUnderlineError
hl.plugins.lsp.LspDiagnosticsUnderlineHint = hl.plugins.lsp
    .DiagnosticUnderlineHint
hl.plugins.lsp.LspDiagnosticsUnderlineInformation = hl.plugins.lsp
    .DiagnosticUnderlineInfo
hl.plugins.lsp.LspDiagnosticsUnderlineWarning = hl.plugins.lsp
    .DiagnosticUnderlineWarn
hl.plugins.lsp.LspDiagnosticsVirtualTextError = hl.plugins.lsp
    .DiagnosticVirtualTextError
hl.plugins.lsp.LspDiagnosticsVirtualTextWarning = hl.plugins.lsp
    .DiagnosticVirtualTextWarn
hl.plugins.lsp.LspDiagnosticsVirtualTextInformation = hl.plugins.lsp
    .DiagnosticVirtualTextInfo
hl.plugins.lsp.LspDiagnosticsVirtualTextHint = hl.plugins.lsp
    .DiagnosticVirtualTextHint

hl.plugins.ale = {
  ALEErrorSign = hl.plugins.lsp.DiagnosticError,
  ALEInfoSign = hl.plugins.lsp.DiagnosticInfo,
  ALEWarningSign = hl.plugins.lsp.DiagnosticWarn,
}

hl.plugins.barbar = {
  BufferCurrent = { fmt = 'bold' },
  BufferCurrentMod = { fg = c.orange, fmt = 'bold,italic' },
  BufferCurrentSign = { fg = c.purple },
  BufferInactiveMod = { fg = c.light_grey, bg = c.bg1, fmt = 'italic' },
  BufferVisible = { fg = c.light_grey, bg = c.bg0 },
  BufferVisibleMod = { fg = c.yellow, bg = c.bg0, fmt = 'italic' },
  BufferVisibleIndex = { fg = c.light_grey, bg = c.bg0 },
  BufferVisibleSign = { fg = c.light_grey, bg = c.bg0 },
  BufferVisibleTarget = { fg = c.light_grey, bg = c.bg0 },
}

hl.plugins.cmp = {
  CmpItemAbbr = colors.Fg,
  CmpItemAbbrDeprecated = { fg = c.light_grey, fmt = 'strikethrough' },
  CmpItemAbbrMatch = colors.Cyan,
  CmpItemAbbrMatchFuzzy = { fg = c.cyan, fmt = 'underline' },
  CmpItemMenu = colors.LightGrey,
  CmpItemKind = { fg = c.purple, fmt = cfg.cmp_itemkind_reverse and 'reverse' },
}

hl.plugins.coc = {
  CocErrorSign = hl.plugins.lsp.DiagnosticError,
  CocHintSign = hl.plugins.lsp.DiagnosticHint,
  CocInfoSign = hl.plugins.lsp.DiagnosticInfo,
  CocWarningSign = hl.plugins.lsp.DiagnosticWarn,
}

hl.plugins.whichkey = {
  WhichKey = colors.Red,
  WhichKeyDesc = colors.Blue,
  WhichKeyGroup = colors.Orange,
  WhichKeySeparator = colors.Green,
}

hl.plugins.gitgutter = {
  GitGutterAdd = { fg = c.green },
  GitGutterChange = { fg = c.blue },
  GitGutterDelete = { fg = c.red },
}

hl.plugins.hop = {
  HopNextKey = { fg = c.red, fmt = 'bold' },
  HopNextKey1 = { fg = c.cyan, fmt = 'bold' },
  HopNextKey2 = { fg = util.darken(c.blue, 0.7) },
  HopUnmatched = colors.Grey,
}

-- comment
hl.plugins.diffview = {
  DiffviewFilePanelTitle = { fg = c.blue, fmt = 'bold' },
  DiffviewFilePanelCounter = { fg = c.purple, fmt = 'bold' },
  DiffviewFilePanelFileName = colors.Fg,
  DiffviewNormal = hl.common.Normal,
  DiffviewCursorLine = hl.common.CursorLine,
  DiffviewVertSplit = hl.common.VertSplit,
  DiffviewSignColumn = hl.common.SignColumn,
  DiffviewStatusLine = hl.common.StatusLine,
  DiffviewStatusLineNC = hl.common.StatusLineNC,
  DiffviewEndOfBuffer = hl.common.EndOfBuffer,
  DiffviewFilePanelRootPath = colors.Grey,
  DiffviewFilePanelPath = colors.Grey,
  DiffviewFilePanelInsertions = colors.Green,
  DiffviewFilePanelDeletions = colors.Red,
  DiffviewStatusAdded = colors.Green,
  DiffviewStatusUntracked = colors.Blue,
  DiffviewStatusModified = colors.Blue,
  DiffviewStatusRenamed = colors.Blue,
  DiffviewStatusCopied = colors.Blue,
  DiffviewStatusTypeChange = colors.Blue,
  DiffviewStatusUnmerged = colors.Blue,
  DiffviewStatusUnknown = colors.Red,
  DiffviewStatusDeleted = colors.Red,
  DiffviewStatusBroken = colors.Red,
}

hl.plugins.gitsigns = {
  GitSignsAdd = colors.Green,
  GitSignsAddLn = colors.Green,
  GitSignsAddNr = colors.Green,
  GitSignsChange = colors.Blue,
  GitSignsChangeLn = colors.Blue,
  GitSignsChangeNr = colors.Blue,
  GitSignsDelete = colors.Red,
  GitSignsDeleteLn = colors.Red,
  GitSignsDeleteNr = colors.Red,
}

hl.plugins.neo_tree = {
  NeoTreeNormal = { fg = c.fg, bg = cfg.transparent and c.none or c.bg_d },
  NeoTreeNormalNC = { fg = c.fg, bg = cfg.transparent and c.none or c.bg_d },
  NeoTreeVertSplit = { fg = c.bg1, bg = cfg.transparent and c.none or c.bg1 },
  NeoTreeWinSeparator = { fg = c.bg1, bg = cfg.transparent and c.none or c.bg1 },
  NeoTreeEndOfBuffer = {
    fg = cfg.ending_tildes and c.bg2 or c.bg_d,
    bg = cfg.transparent and c.none or c.bg_d,
  },
  NeoTreeRootName = { fg = c.orange, fmt = 'bold' },
  NeoTreeGitAdded = colors.Green,
  NeoTreeGitDeleted = colors.Red,
  NeoTreeGitModified = colors.Yellow,
  NeoTreeGitConflict = { fg = c.red, fmt = 'bold,italic' },
  NeoTreeGitUntracked = { fg = c.red, fmt = 'italic' },
  NeoTreeIndentMarker = colors.Grey,
  NeoTreeSymbolicLinkTarget = colors.Purple,
}

hl.plugins.neotest = {
  NeotestAdapterName = { fg = c.purple, fmt = 'bold' },
  NeotestDir = colors.Cyan,
  NeotestExpandMarker = colors.Grey,
  NeotestFailed = colors.Red,
  NeotestFile = colors.Cyan,
  NeotestFocused = { fmt = 'bold,italic' },
  NeotestIndent = colors.Grey,
  NeotestMarked = { fg = c.orange, fmt = 'bold' },
  NeotestNamespace = colors.Blue,
  NeotestPassed = colors.Green,
  NeotestRunning = colors.Yellow,
  NeotestWinSelect = { fg = c.cyan, fmt = 'bold' },
  NeotestSkipped = colors.LightGrey,
  NeotestTarget = colors.Purple,
  NeotestTest = colors.Fg,
  NeotestUnknown = colors.LightGrey,
}

hl.plugins.nvim_tree = {
  NvimTreeNormal = { fg = c.fg, bg = cfg.transparent and c.none or c.bg0 },
  NvimTreeVertSplit = { fg = c.bg_d, bg = cfg.transparent and c.none or c.bg_d },
  NvimTreeEndOfBuffer = {
    fg = cfg.ending_tildes and c.bg2 or c.bg0,
    bg = cfg.transparent and c.none or c.bg0,
  },
  NvimTreeRootFolder = { fg = c.orange, fmt = 'bold' },
  NvimTreeGitDirty = colors.Yellow,
  NvimTreeGitNew = colors.Green,
  NvimTreeGitDeleted = colors.Red,
  NvimTreeSpecialFile = { fg = c.yellow, fmt = 'underline' },
  NvimTreeIndentMarker = colors.Fg,
  NvimTreeImageFile = { fg = c.dark_purple },
  NvimTreeSymlink = colors.Purple,
  NvimTreeFolderName = colors.Blue,
}
hl.plugins.telescope = {
  TelescopeBorder = colors.Red,
  TelescopePromptBorder = colors.Purple,
  TelescopeResultsBorder = colors.Purple,
  TelescopePreviewBorder = colors.Purple,
  TelescopeMatching = { fg = c.orange, fmt = 'bold' },
  TelescopePromptPrefix = colors.Green,
  TelescopeSelection = { bg = c.bg2 },
  TelescopeSelectionCaret = colors.Yellow,
}

hl.plugins.dashboard = {
  DashboardShortCut = colors.Blue,
  DashboardHeader = colors.Yellow,
  DashboardCenter = colors.Cyan,
  DashboardFooter = { fg = c.dark_red, fmt = 'italic' },
}

hl.plugins.outline = {
  FocusedSymbol = { fg = c.purple, bg = c.bg2, fmt = 'bold' },
  AerialLine = { fg = c.purple, bg = c.bg2, fmt = 'bold' },
}

hl.plugins.navic = {
  NavicText = { fg = c.fg },
  NavicSeparator = { fg = c.light_grey },
}

hl.plugins.ts_rainbow = {
  rainbowcol1 = colors.LightGrey,
  rainbowcol2 = colors.Yellow,
  rainbowcol3 = colors.Blue,
  rainbowcol4 = colors.Orange,
  rainbowcol5 = colors.Purple,
  rainbowcol6 = { fg = util.lighten(c.light_grey, 0.75) },
  rainbowcol7 = colors.Red,
}

hl.plugins.ts_rainbow2 = {
  TSRainbowRed = colors.Red,
  TSRainbowYellow = colors.Yellow,
  TSRainbowBlue = colors.Blue,
  TSRainbowOrange = colors.Orange,
  TSRainbowGreen = { fg = util.lighten(c.light_grey, 0.75) },
  TSRainbowViolet = colors.Purple,
  TSRainbowCyan = colors.Cyan,
}

hl.plugins.indent_blankline = {
  IndentBlanklineIndent1 = colors.Blue,
  IndentBlanklineIndent2 = colors.Green,
  IndentBlanklineIndent3 = colors.Cyan,
  IndentBlanklineIndent4 = colors.LightGrey,
  IndentBlanklineIndent5 = colors.Purple,
  IndentBlanklineIndent6 = colors.Red,
  IndentBlanklineChar = { fg = c.bg1, fmt = 'nocombine' },
  IndentBlanklineContextChar = { fg = c.light_grey, fmt = 'nocombine' },
  IndentBlanklineContextStart = { bg = c.bg1 },
  IndentBlanklineContextSpaceChar = { fmt = 'nocombine' },
}

hl.plugins.mini = {
  MiniCompletionActiveParameter = { fmt = 'underline' },

  MiniCursorword = { fmt = 'underline' },
  MiniCursorwordCurrent = { fmt = 'underline' },

  MiniIndentscopeSymbol = { fg = c.grey },
  MiniIndentscopePrefix = { fmt = 'nocombine' }, -- Make it invisible

  MiniJump = { fg = c.purple, fmt = 'underline', sp = c.purple },

  MiniJump2dSpot = { fg = c.red, fmt = 'bold,nocombine' },

  MiniStarterCurrent = { fmt = 'nocombine' },
  MiniStarterFooter = { fg = c.dark_red, fmt = 'italic' },
  MiniStarterHeader = colors.Yellow,
  MiniStarterInactive = { fg = c.grey, fmt = cfg.code_style.comments },
  MiniStarterItem = { fg = c.fg, bg = cfg.transparent and c.none or c.bg0 },
  MiniStarterItemBullet = { fg = c.grey },
  MiniStarterItemPrefix = { fg = c.yellow },
  MiniStarterSection = colors.LightGrey,
  MiniStarterQuery = { fg = c.cyan },

  MiniStatuslineDevinfo = { fg = c.fg, bg = c.bg2 },
  MiniStatuslineFileinfo = { fg = c.fg, bg = c.bg2 },
  MiniStatuslineFilename = { fg = c.grey, bg = c.bg1 },
  MiniStatuslineInactive = { fg = c.grey, bg = c.bg0 },
  MiniStatuslineModeCommand = { fg = c.bg0, bg = c.yellow, fmt = 'bold' },
  MiniStatuslineModeInsert = { fg = c.bg0, bg = c.blue, fmt = 'bold' },
  MiniStatuslineModeNormal = { fg = c.bg0, bg = c.green, fmt = 'bold' },
  MiniStatuslineModeOther = { fg = c.bg0, bg = c.cyan, fmt = 'bold' },
  MiniStatuslineModeReplace = { fg = c.bg0, bg = c.red, fmt = 'bold' },
  MiniStatuslineModeVisual = { fg = c.bg0, bg = c.purple, fmt = 'bold' },

  MiniSurround = { fg = c.bg0, bg = c.orange },

  MiniTablineCurrent = { fmt = 'bold' },
  MiniTablineFill = { fg = c.grey, bg = c.bg1 },
  MiniTablineHidden = { fg = c.fg, bg = c.bg1 },
  MiniTablineModifiedCurrent = { fg = c.orange, fmt = 'bold,italic' },
  MiniTablineModifiedHidden = { fg = c.light_grey, bg = c.bg1, fmt = 'italic' },
  MiniTablineModifiedVisible = { fg = c.yellow, bg = c.bg0, fmt = 'italic' },
  MiniTablineTabpagesection = { fg = c.bg0, bg = c.bg_yellow },
  MiniTablineVisible = { fg = c.light_grey, bg = c.bg0 },

  MiniTestEmphasis = { fmt = 'bold' },
  MiniTestFail = { fg = c.red, fmt = 'bold' },
  MiniTestPass = { fg = c.green, fmt = 'bold' },

  MiniTrailspace = { bg = c.red },
}

hl.langs.c = {
  cInclude = colors.Blue,
  cStorageClass = colors.Purple,
  cTypedef = colors.Purple,
  cDefine = colors.Cyan,
  cTSInclude = colors.Blue,
  cTSConstant = colors.Cyan,
  cTSConstMacro = colors.Purple,
  cTSOperator = colors.Purple,
}

hl.langs.cpp = {
  cppStatement = { fg = c.purple, fmt = 'bold' },
  cppTSInclude = colors.Blue,
  cppTSConstant = colors.Cyan,
  cppTSConstMacro = colors.Purple,
  cppTSOperator = colors.Purple,
}

hl.langs.markdown = {
  markdownBlockquote = colors.Grey,
  markdownBold = { fg = c.none, fmt = 'bold' },
  markdownBoldDelimiter = colors.Grey,
  markdownCode = colors.Green,
  markdownCodeBlock = colors.Green,
  markdownCodeDelimiter = colors.Yellow,
  markdownH1 = { fg = c.red, fmt = 'bold' },
  markdownH2 = { fg = c.purple, fmt = 'bold' },
  markdownH3 = { fg = c.orange, fmt = 'bold' },
  markdownH4 = { fg = c.red, fmt = 'bold' },
  markdownH5 = { fg = c.purple, fmt = 'bold' },
  markdownH6 = { fg = c.orange, fmt = 'bold' },
  markdownHeadingDelimiter = colors.Grey,
  markdownHeadingRule = colors.Grey,
  markdownId = colors.Yellow,
  markdownIdDeclaration = colors.Red,
  markdownItalic = { fg = c.none, fmt = 'italic' },
  markdownItalicDelimiter = { fg = c.grey, fmt = 'italic' },
  markdownLinkDelimiter = colors.Grey,
  markdownLinkText = colors.Red,
  markdownLinkTextDelimiter = colors.Grey,
  markdownListMarker = colors.Red,
  markdownOrderedListMarker = colors.Red,
  markdownRule = colors.Purple,
  markdownUrl = { fg = c.blue, fmt = 'underline' },
  markdownUrlDelimiter = colors.Grey,
  markdownUrlTitleDelimiter = colors.Green,
}

hl.langs.php = {
  phpFunctions = { fg = c.fg, fmt = cfg.code_style.functions },
  phpMethods = colors.Cyan,
  phpStructure = colors.Purple,
  phpOperator = colors.Purple,
  phpMemberSelector = colors.Fg,
  phpVarSelector = { fg = c.orange, fmt = cfg.code_style.variables },
  phpIdentifier = { fg = c.orange, fmt = cfg.code_style.variables },
  phpBoolean = colors.Cyan,
  phpNumber = colors.Orange,
  phpHereDoc = colors.Green,
  phpNowDoc = colors.Green,
  phpSCKeyword = { fg = c.purple, fmt = cfg.code_style.keywords },
  phpFCKeyword = { fg = c.purple, fmt = cfg.code_style.keywords },
  phpRegion = colors.Blue,
}

hl.langs.scala = {
  scalaNameDefinition = colors.Fg,
  scalaInterpolationBoundary = colors.Purple,
  scalaInterpolation = colors.Purple,
  scalaTypeOperator = colors.Red,
  scalaOperator = colors.Red,
  scalaKeywordModifier = { fg = c.red, fmt = cfg.code_style.keywords },
}

hl.langs.tex = {
  latexTSInclude         = colors.Blue,
  latexTSFuncMacro       = { fg = c.fg, fmt = cfg.code_style.functions },
  latexTSEnvironment     = { fg = c.cyan, fmt = 'bold' },
  latexTSEnvironmentName = colors.Yellow,
  texCmdEnv              = colors.Cyan,
  texEnvArgName          = colors.Yellow,
  latexTSTitle           = colors.Green,
  latexTSType            = colors.Blue,
  latexTSMath            = colors.Orange,
  texMathZoneX           = colors.Orange,
  texMathZoneXX          = colors.Orange,
  texMathDelimZone       = colors.LightGrey,
  texMathDelim           = colors.Purple,
  texMathOper            = colors.Red,
  texCmd                 = colors.Purple,
  texCmdPart             = colors.Blue,
  texCmdPackage          = colors.Blue,
  texPgfType             = colors.Yellow,
}

hl.langs.vim = {
  vimOption = colors.Red,
  vimSetEqual = colors.Yellow,
  vimMap = colors.Purple,
  vimMapModKey = colors.Orange,
  vimNotation = colors.Red,
  vimMapLhs = colors.Fg,
  vimMapRhs = colors.Blue,
  vimVar = { fg = c.fg, fmt = cfg.code_style.variables },
  vimCommentTitle = { fg = c.yellow, fmt = cfg.code_style.comments },
}

local lsp_kind_icons_color = {
  Default = c.purple,
  Array = c.yellow,
  Boolean = c.orange,
  Class = c.yellow,
  Color = c.green,
  Constant = c.orange,
  Constructor = c.blue,
  Enum = c.purple,
  EnumMember = c.yellow,
  Event = c.yellow,
  Field = c.purple,
  File = c.blue,
  Folder = c.orange,
  Function = c.blue,
  Interface = c.green,
  Key = c.cyan,
  Keyword = c.cyan,
  Method = c.blue,
  Module = c.orange,
  Namespace = c.red,
  Null = c.grey,
  Number = c.orange,
  Object = c.red,
  Operator = c.red,
  Package = c.yellow,
  Property = c.cyan,
  Reference = c.orange,
  Snippet = c.red,
  String = c.green,
  Struct = c.purple,
  Text = c.light_grey,
  TypeParameter = c.red,
  Unit = c.green,
  Value = c.orange,
  Variable = c.purple,
}

function M.setup()
  -- define cmp and aerial kind highlights with lsp_kind_icons_color
  for kind, color in pairs(lsp_kind_icons_color) do
    hl.plugins.cmp['CmpItemKind' .. kind] = {
      fg = color,
      fmt = cfg.cmp_itemkind_reverse and 'reverse',
    }
    hl.plugins.outline['Aerial' .. kind .. 'Icon'] = { fg = color }
    hl.plugins.navic['NavicIcons' .. kind] = { fg = color }
  end

  vim_highlights(hl.common)
  vim_highlights(hl.syntax)
  vim_highlights(hl.treesitter)
  if hl.lsp then
    for k in pairs(hl.lsp) do
      vim.api.nvim_set_hl(0, k, hl.lsp[k])
    end
  end
  for _, group in pairs(hl.langs) do vim_highlights(group) end
  for _, group in pairs(hl.plugins) do vim_highlights(group) end

  -- user defined highlights: vim_highlights function cannot be used because it sets an attribute to none if not specified
  local function replace_color(prefix, color_name)
    if not color_name then return '' end
    if color_name:sub(1, 1) == '$' then
      local name = color_name:sub(2, -1)
      color_name = c[name]
      if not color_name then
        vim.schedule(function()
          vim.notify('bamboo.nvim: unknown color "' .. name .. '"',
            vim.log.levels.ERROR, { title = 'bamboo.nvim' })
        end)
        return ''
      end
    end
    return prefix .. '=' .. color_name
  end

  for group_name, group_settings in pairs(vim.g.bamboo_config.highlights) do
    vim.api.nvim_command(string.format('highlight %s %s %s %s %s', group_name,
      replace_color('guifg', group_settings.fg),
      replace_color('guibg', group_settings.bg),
      replace_color('guisp', group_settings.sp),
      replace_color('gui', group_settings.fmt)))
  end
end

return M
