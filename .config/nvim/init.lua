-- Bootstrap packer.
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd('packadd packer.nvim')
end

require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use {
        'lewis6991/gitsigns.nvim', 
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('gitsigns').setup()
        end
    }
    use 'neovim/nvim-lspconfig'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
    }
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
    }

    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/vim-vsnip",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp",
        }
    }
    use 'dag/vim-fish'
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    use "projekt0n/github-nvim-theme"
end)

-- Theme
vim.opt.termguicolors = true
require("github-theme").setup({
    -- theme_style = "light_default",
    theme_style = "dark_default",
    overrides = function(c)
        local types = require('github-theme.types')
        local Styles = types.gt.HighlightStyle

        return {
            StatusLine = { fg = c.bg, bg = c.blue, style = Styles.Bold },
            StatusLineNC = { fg = c.bg, bg = c.bright_blue },
        }
    end
})

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

vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

vim.opt.autowrite = true
vim.opt.completeopt = { "menu", "menuone", "noselect"}
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
vim.opt.listchars = "tab:» ,lead:·,trail:·,extends:»,precedes:«"
-- set wrapmargin=2

-- language specific
local filetype_autocmds = {
    c = { command = "setlocal ts=8 noexpandtab" },
    go = { command = "setlocal ts=4 noexpandtab" },
    sh = { command = "setlocal ts=4 noexpandtab" }
}

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

vim.keymap.set("i", "<C-e>", "<C-o>de")

vim.keymap.set("", "<leader>y", '"+y', { remap = true })
vim.keymap.set("n", "<leader>p", '"+P')

--Remap for dealing with word wrap
vim.keymap.set('n', 'k',      "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j',      "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', '<Up>',   "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', '<Down>', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Telescope Mappings
-- TODO: use git_files and fall back to find_files
vim.keymap.set("n", "<leader>ff", require('telescope.builtin').find_files)
vim.keymap.set("n", "<leader>fg", require('telescope.builtin').live_grep)
vim.keymap.set("n", "<leader>fb", require('telescope.builtin').buffers)
vim.keymap.set("n", "<leader>fh", require('telescope.builtin').help_tags)


local cmp = require('cmp')

mapping = {
  ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
  ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
  ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
  ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
  ['<C-d>'] = cmp.mapping.scroll_docs(-4),
  ['<C-f>'] = cmp.mapping.scroll_docs(4),
  ['<C-Space>'] = cmp.mapping.complete(),
  ['<C-e>'] = cmp.mapping.close(),
  ['<CR>'] = cmp.mapping.confirm({
    behavior = cmp.ConfirmBehavior.Replace,
    select = true,
  })
}

cmp.setup({
    sources = {
        {name = 'buffer'}, 
        {name = 'nvim_lsp'},
        {name = 'nvim_lua'},
        {name = 'path'},
        {name = 'vsnip'},
    },
    mapping = mapping,
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
})

cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
    }
})

-- Treesitter
local ts = require'nvim-treesitter.configs'
ts.setup {
    ensure_installed = 'all',
    highlight = { enable = true },
    additional_vim_regex_highlighting = false,
    indent = { enable = true },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
            },
        },
    }
}

-- LSP stuff
local lspconfig = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { buffer = bufnr }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
        vim.inspect(vim.lsp.buf.list_workspace_folders())
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<F5>', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', '<F6>', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
    vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
--
-- TODO
-- https://neovim.discourse.group/t/automatically-choose-one-language-server-to-format-code-when-using-multiple-language-servers/800/5
local servers = { "gopls", "pylsp", "bashls" }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        capabilities = capabilities,
        on_attach = on_attach,
    }
end

lspconfig.efm.setup{
    init_options = {documentFormatting = true},
    filetypes = {"sh", "go"},
    on_attach = on_attach,
    capabilities = capabilities,
    single_file_support = true,
    settings = {
        rootMarkers = {".git/"},
        languages = {
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

-- Highlight on yank
local convenience_group = vim.api.nvim_create_augroup('convenience', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = convenience_group,
    pattern = '*',
})

-- Return to last location
vim.api.nvim_create_autocmd('BufReadPost', {
    command = [[if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit' | exe "normal! g`\"" | endif]],
    group = convenience_group,
    pattern = '*',
})

local filetypes_group = vim.api.nvim_create_augroup('filetypes', { clear = true })
for k, v in pairs(filetype_autocmds) do
    vim.api.nvim_create_autocmd('FileType', {
        command = v.command,
        group = filetypes_group,
        pattern = k,
    })
end
