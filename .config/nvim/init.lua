-- TODO: Migrate to packer.
require 'paq-nvim' {
    'savq/paq-nvim';                  -- Let Paq manage itself

    'tomtom/tcomment_vim';
    'airblade/vim-gitgutter';

    'nvim-lua/popup.nvim';
    'nvim-lua/plenary.nvim';
    'nvim-telescope/telescope.nvim';

    'hrsh7th/nvim-compe';
    'dag/vim-fish';
    'nvim-treesitter/nvim-treesitter';
    'neovim/nvim-lspconfig';
}

-- Theme
-- vim.cmd("colorscheme default")
vim.cmd("highlight Search ctermbg=12")
vim.cmd("highlight clear SignColumn")
vim.cmd("highlight ColorColumn ctermbg=darkgrey")
vim.cmd("highlight LineNr ctermfg=grey")
vim.cmd("highlight Pmenu ctermbg=white ctermfg=black")
vim.cmd("highlight PmenuSel ctermbg=black ctermfg=white")
-- highlight OverLength ctermbg=red ctermfg=white
-- match OverLength /\%81v.\+/

-- Settings
-- Disable built-in plugins
vim.g.loaded_2html_plugin = true
vim.g.loaded_matchparen = true
vim.g.loaded_netrwPlugin = true
vim.g.loaded_rrhelper = true
vim.g.loaded_tutor_mode_plugin = true
-- let g:loaded_gzip              = 1
-- let g:loaded_spellfile_plugin  = 1
-- let g:loaded_tarPlugin         = 1
-- let g:loaded_zipPlugin         = 1

vim.opt.autowrite = true
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.scrolloff = 3
vim.opt.sidescroll = 3
vim.opt.expandtab = true
vim.opt.undofile = true
vim.opt.smartindent = true
vim.opt.list = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.mouse = "a"
vim.opt.inccommand = "nosplit"
vim.opt.redrawtime = 200
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.secure = true
vim.opt.magic = true
vim.opt.showmatch = true
vim.opt.linebreak = true
vim.opt.signcolumn = "yes"
vim.opt.completeopt = { "menuone", "noselect" }

if vim.fn["executable('rg')"] then
    vim.opt.grepprg = "rg --vimgrep --no-heading"
    vim.opt.grepformat="%f:%l:%c:%m,%f:%l:%m"
end

-- set listchars=tab:▸\ ,eol:¬,space:.
-- set wrapmargin=2

vim.g.python_highlight_all = true
vim.g.tex_flavor = 'latex'
vim.g.is_bash = true
vim.g.vimsyn_embed = 'lp'

-- language specific
vim.g.man_hardwrap = true
vim.g.cinoptions = "l1"

local options = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "k", "gk", options)
vim.api.nvim_set_keymap("n", "j", "gj", options)
vim.api.nvim_set_keymap("n", "<Up>", "gk", options)
vim.api.nvim_set_keymap("n", "<Down>", "gj", options)

vim.api.nvim_set_keymap("n", "Y", "y$", options)
vim.api.nvim_set_keymap("", "<leader>y", '"+y', { silent = true })
vim.api.nvim_set_keymap("n", "<leader>p", '"+p', options)

-- Trash Ex mode.
vim.api.nvim_set_keymap("n", "Q", "<Nop>", options)
-- TODO: to be the default int the future
vim.api.nvim_set_keymap("n", "<C-L>", ":nohlsearch<CR>", options)

-- Telescope mappings.
vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", options)
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", options)
vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", options)
vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", options)

-- Treesitter
local ts = require'nvim-treesitter.configs'
ts.setup {ensure_installed = 'maintained', highlight = {enable = true}}

-- LSP stuff
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  --Enable completion triggered by <c-x><c-o>
  vim.api.buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  vim.api.buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  vim.api.buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  vim.api.buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "gopls", "pylsp", "bashls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- delay update diagnostics
    update_in_insert = false,
  }
)

-- TODO: Add lazy loading
nvim_lsp.efm.setup{
  init_options = {documentFormatting = true},
    filetypes = {"sh"},
    settings = {
        rootMarkers = {".git/"},
        languages = {
            sh = {
              {
                      lintCommand = 'shellcheck -f gcc -x',
                      lintSource = 'shellcheck',
                      lintFormats= {'%f:%l:%c: %trror: %m', '%f:%l:%c: %tarning: %m', '%f:%l:%c: %tote: %m'}
              }
            }
        }
    }
}

require'compe'.setup {
    source = {
        path = true;
        buffer = true;
        calc = true;
        nvim_lsp = true;
        nvim_lua = true;
        vsnip = true;
        emoji = true;
    };
}

-- https://github.com/norcalli/nvim_utils/blob/master/lua/nvim_utils.lua#L554-L56h
function nvim_create_augroups(definitions)
	for group_name, definition in pairs(definitions) do
		vim.api.nvim_command('augroup '..group_name)
		vim.api.nvim_command('autocmd!')
		for _, def in ipairs(definition) do
			local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
			vim.api.nvim_command(command)
		end
		vim.api.nvim_command('augroup END')
	end
end

local autocmds = {
	filetypes = {
		{"FileType",     "c",   "setlocal ts=8 noexpandtab"};
		{"FileType",     "go",  "setlocal ts=4 noexpandtab"};
    };
    convenience = {
		{"TextYankPost", "*",   "silent! lue require'vim.highlight'.on_yank()"};
		{"BufReadPost",  "*",   [[if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit' | exe "normal! g`\"" | endif]]};
	};
}

nvim_create_augroups(autocmds)

