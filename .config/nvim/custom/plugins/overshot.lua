--                              _     __
--   ____ _   _____  __________(_)___/ /__
--  / __ \ | / / _ \/ ___/ ___/ / __  / _ \
-- / /_/ / |/ /  __/ /  / /  / / /_/ /  __/
-- \____/|___/\___/_/  /_/  /_/\__,_/\___/
--

local M = {}

M.mason = {
	ensure_installed = {
		"lua-language-server",
		"bash-language-server",
	},
}

M.mason_lspconfig = {
	ensure_installed = {
		"sumneko_lua",
		"bashls",
	},
}

M.telescope = {
	defaults = {
		vimgrep_arguments = {
			"rg",
			"-L",
      "--hidden",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
	},
}

return M
