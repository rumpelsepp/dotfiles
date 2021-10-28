-- Bootstrap packer.
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd('packadd packer.nvim')
end

require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use {
        'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
        config = function() require('gitsigns').setup() end
    }
    use { 'nvim-telescope/telescope.nvim', requires = {'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim' }}
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/vim-vsnip",
            "hrsh7th/cmp-buffer",
        }
    }
    use 'hrsh7th/cmp-nvim-lsp'
    use 'dag/vim-fish'
    use 'neovim/nvim-lspconfig'
    use {
        'phaazon/hop.nvim',
        as = 'hop',
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            require'hop'.setup { keys = 'uiaeosnrtdy' }
        end
    }
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
end)

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
-- vim.g.loaded_2html_plugin = true
-- vim.g.loaded_matchparen = true
vim.g.loaded_netrwPlugin = true
-- vim.g.loaded_rrhelper = true
-- vim.g.loaded_tutor_mode_plugin = true
-- let g:loaded_gzip              = 1
-- let g:loaded_spellfile_plugin  = 1
-- let g:loaded_tarPlugin         = 1
-- let g:loaded_zipPlugin         = 1

-- vim.opt.termguicolors = true
vim.opt.autowrite = true
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.magic = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.redrawtime = 200
vim.opt.scrolloff = 3
vim.opt.secure = true
vim.opt.shiftwidth = 0
vim.opt.showmatch = true
vim.opt.sidescroll = 3
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.undofile = true

-- vim.opt.listchars ="tab:▸ ,eol:¬,lead:·"
-- vim.opt.listchars ="tab:▸ ,lead:·"
vim.opt.listchars ="tab:» ,lead:·"
-- set wrapmargin=2

-- language specific
vim.g.python_highlight_all = true
vim.g.tex_flavor = 'latex'
vim.g.is_bash = true
vim.g.man_hardwrap = true
vim.g.cinoptions = "l1"
vim.g.vimsyn_embed = 'lp'

-- I bet this leader is not in use! :D
vim.g.mapleader = 'ä'

if vim.env.TMUX then
    vim.g.clipboard = {
        name = 'tmux',
        copy = {
            ["+"] = {'tmux', 'load-buffer', '-w', '-'},
            ["*"] = {'tmux', 'load-buffer', '-w', '-'},
        },
        paste = {
            ["+"] = {'bash', '-c', 'tmux refresh-client -l && sleep 0.2 && tmux save-buffer -'},
            ["*"] = {'bash', '-c', 'tmux refresh-client -l && sleep 0.2 && tmux save-buffer -'},
        },
        cache_enabled = false,
    }
end

local options = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "k", "gk", options)
vim.api.nvim_set_keymap("n", "j", "gj", options)
vim.api.nvim_set_keymap("n", "<Up>", "gk", options)
vim.api.nvim_set_keymap("n", "<Down>", "gj", options)
vim.api.nvim_set_keymap("i", "<C-e>", "<C-o>de", options)

vim.api.nvim_set_keymap("", "<leader>y", '"+y', { silent = true })
vim.api.nvim_set_keymap("n", "<leader>p", '"+P', options)

-- Telescope Mappings
vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", options)
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", options)
vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", options)
vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", options)

-- Hop Mappings
vim.api.nvim_set_keymap("n", "<leader>h", "<cmd>HopWord<cr>", options)


local cmp = require'cmp'
cmp.setup({
    sources = {
        {name = 'buffer'}, 
        {name = 'nvim_lsp'},
        {name = 'nvim_lua'},
        {name = 'path'},
    }
})

-- Treesitter
local ts = require'nvim-treesitter.configs'
ts.setup {ensure_installed = 'maintained', highlight = {enable = true}}

-- LSP stuff
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    --Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<F5>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', '<F6>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "gopls", "pylsp", "bashls" }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 150,
        },
        on_attach = on_attach,
    }
end

nvim_lsp.efm.setup{
    init_options = {documentFormatting = true},
    filetypes = {"sh", "python", "go"},
    on_attach = on_attach,
    settings = {
        rootMarkers = {".git/"},
        languages = {
            python = {
                {
                    formatCommand = 'black --quiet --target-version py39 -',
                    formatStdin = true,
                }
            },
            go = {
                {
                    formatCommand = 'goimports',
                    formatStdin = true,
                }
            },
            sh = {
                {
                    lintCommand = 'shellcheck -f gcc -x',
                    lintSource = 'shellcheck',
                    lintFormats = {'%f:%l:%c: %trror: %m', '%f:%l:%c: %tarning: %m', '%f:%l:%c: %tote: %m'},
                    formatCommand = 'shfmt -',
                    formatStdin = true,
                }
            },
        }
    }
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
        {"FileType", "c",  "setlocal ts=8 noexpandtab"};
        {"FileType", "go", "setlocal ts=4 noexpandtab"};
        {"FileType", "sh", "setlocal ts=4 noexpandtab"};
    };
    convenience = {
        {"TextYankPost", "*", "silent! lua require'vim.highlight'.on_yank()"};
        {"BufReadPost",  "*", [[if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit' | exe "normal! g`\"" | endif]]};
    };
}

nvim_create_augroups(autocmds)

