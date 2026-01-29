local use = require("colorschemes.fn").use

local schemes = {
  abstract = { "Abstract-IDE/Abstract-cs", "abscs" },
  lackluster = { "slugbyte/lackluster.nvim", "lackluster", {} },
  melange = { "savq/melange-nvim", "melange" },
  miasma = { "xero/miasma.nvim", "miasma" },
  slack = { "ntk148v/slack.nvim", "slack" },
  sonokai = { "sainnhe/sonokai", "sonokai" },
}

use(schemes.sonokai)
