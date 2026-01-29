vim.cmd([[set noswapfile]])
vim.cmd([[set mouse=]])

vim.o.mouse = 'a'
vim.o.winborder = "rounded"
--vim.o.tabstop = 8
--vim.o.shiftwidth = 8
vim.o.showtabline = 1
vim.o.wrap = false
vim.o.cursorcolumn = false
vim.o.ignorecase = false
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.termguicolors = true
vim.o.undofile = true 
vim.o.incsearch = true
vim.o.hlsearch = false
vim.o.clipboard = 'unnamedplus'
vim.o.signcolumn = 'yes'
vim.o.updatetime = 300
vim.o.completeopt = 'menu,menuone,noselect'
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- statusline settings
vim.o.laststatus = 2
vim.o.statusline = '%f %m %r%= %y %l:%c %p%%'

-- netrw settings
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 0
vim.g.netrw_winsize = 25

vim.g.mapleader = " "
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set('n', '<leader>e', ':Explore<CR>')
vim.keymap.set('n', '<leader>E', ':Lexplore<CR>')
vim.keymap.set('n', '<leader>r', ':set number! <CR> :set relativenumber!<CR>')

local is_windows = vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1
local pack_path = vim.fn.stdpath('data') .. '/site/pack/plugins/start'

vim.pack.add({
	{src = 'https://github.com/xiantang/darcula-dark.nvim'},
	{src = 'https://github.com/nvim-treesitter/nvim-treesitter'},
	{src = 'https://github.com/neovim/nvim-lspconfig'},
	{src = 'https://github.com/nvim-mini/mini.pairs'},
})

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save file' })
vim.keymap.set('n', '<leader>q', '<cmd>q<CR>', { desc = 'Quit' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous Diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic' })
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Diagnostic list' })

vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- colorscheme and some ui tweaks
vim.cmd("colorscheme darcula-dark")
vim.cmd(":hi statusline guibg=NONE guifg='#7f9f7f'")
vim.cmd(":hi Normal guibg=NONE")
vim.cmd(":hi tabline guibg=NONE")

-- Language-specific settings
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go',
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = false
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'cpp' },
  callback = function()
    vim.opt_local.tabstop = 8
    vim.opt_local.shiftwidth = 8
  end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = 'rust',
	callback = function()
		vim.opt_local.tabstop = 8
		vim.opt_local.shiftwidth = 4
	end,
})

local treesitter_ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if treesitter_ok then
	treesitter.setup({
		ensure_installed = { 'c', 'go', 'bash', 'perl', 'python', 'lua' },
		auto_install = true,
		highlight = {
			enable = true,
		        additional_vim_regex_highlighting = false,
	},
	indent = { enable = true },
})
end

local on_attach = function(client, bufnr)
	local opts = { buffer = bufnr, noremap = true, slient = true }
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
	vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, opts)
end

vim.lsp.config.clangd = {
	cmd = { 'clang' },
	filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
	root_markers = { '.git', 'compile_commands.json' },
	on_attach = on_attach,
}

vim.lsp.config.gopls = {
	cmd = { 'gopls' },
	filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
	root_markers = { 'go.work', 'go.mod', '.git' },
	settings = {
		gopls = {
			analyses = { unusedparams = true },
			staticcheck = true,
		},
	},
	on_attach = on_attach,
}

vim.lsp.config.perlnavigator = {
	cmd = { 'perlnavigator' },
	filetypes = { 'perl' },
	root_markers = { '.git' },
	on_attach = on_attach,
}

vim.lsp.config.pyright = {
	cmd = { 'pyright-langserver', '--stdio' },
	filetypes = { 'python' },
	root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git' },
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "basic",
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
			},
		},
	},
	on_attach = on_attach,
}

vim.lsp.enable({'clangd', 'gopls', 'perlnavigator', 'pyright'})
