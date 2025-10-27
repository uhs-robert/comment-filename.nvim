local M = {}

M.defaults = {
	enabled = true,
	patterns = {
		"*.js",
		"*.jsx",
		"*.ts",
		"*.tsx",
		"*.mjs",
		"*.cjs",
		"*.lua",
		"*.py",
		"*.rb",
		"*.pl",
		"*.php",
		"*.r",
		"*.c",
		"*.h",
		"*.cpp",
		"*.hpp",
		"*.cc",
		"*.hh",
		"*.m",
		"*.mm",
		"*.cu",
		"*.rs",
		"*.go",
		"*.java",
		"*.kt",
		"*.kts",
		"*.scala",
		"*.groovy",
		"*.swift",
		"*.dart",
		"*.sh",
		"*.bash",
		"*.zsh",
		"*.fish",
		"*.html",
		"*.htm",
		"*.css",
		"*.scss",
		"*.less",
		"*.vue",
		"*.svelte",
		"*.astro",
		"*.sql",
		"*.toml",
		"*.conf",
		"*.ini",
		"*.gitconfig",
		"*.nginx",
		"Dockerfile",
		"dockerfile",
		"*.mk",
		"Makefile",
		"*.cmake",
		"CMakeLists.txt",
		"*.nix",
		"Chart.yaml",
	},
	allowed_ft = {}, -- map<string,bool>, empty = allow by pattern only
	which_key = true,
	skip_gitignored = true,
}

function M.merge(opts)
	M.opts = vim.tbl_deep_extend("force", vim.deepcopy(M.defaults), opts or {})
	return M.opts
end

function M.get()
	return M.opts or M.defaults
end

return M
