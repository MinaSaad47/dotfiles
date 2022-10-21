local status, null_ls = pcall(require, "null-ls")

if not status then
	vim.notify("could not require `null-ls`")
	return
end

local disabled_filetypes = {
    'rust'
}

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local completion = null_ls.builtins.completion
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
	debug = true,
	sources = {
		completion.spell,
		code_actions.cspell,
		formatting.stylua.with({disabled_filetypes = disabled_filetypes}),
		diagnostics.eslint,
		completion.luasnip,
		formatting.prettierd.with({disabled_filetypes = disabled_filetypes}),
		completion.vsnip,
	},
})
