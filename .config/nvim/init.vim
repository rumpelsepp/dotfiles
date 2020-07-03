if exists('g:vscode')
    finish
endif

call plug#begin('~/.local/share/nvim/plugged')
Plug 'tomtom/tcomment_vim'
Plug 'machakann/vim-sandwich'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'dag/vim-fish'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'kyazdani42/nvim-tree.lua'
" Plug 'sheerun/vim-polyglot'
" Plug 'tpope/vim-surround'
" Plug 'cohama/lexima.vim'
" Plug 'tpope/vim-fugitive'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'morhetz/gruvbox'
Plug 'neovim/nvim-lsp'
" Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp'
" Plug 'mattn/vim-lsp-settings'
call plug#end()

" Disable built-in plugins
let g:loaded_2html_plugin      = 1
" let g:loaded_gzip              = 1
let g:loaded_matchparen        = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_rrhelper          = 1
let g:loaded_spellfile_plugin  = 1
" let g:loaded_tarPlugin         = 1
" let g:loaded_zipPlugin         = 1
let g:loaded_matchit           = 1
let g:loaded_tutor_mode_plugin = 1

" settings
set autowrite
set tabstop=4
set shiftwidth=0
set scrolloff=3
set sidescroll=3
set expandtab
set undofile
set smartindent
set list
set smartcase
set mouse=a
set inccommand=nosplit
set redrawtime=200
set splitbelow
set splitright
set secure
set magic
set showmatch
" set wrapmargin=2
set linebreak
" set signcolumn=yes

" theme
let python_highlight_all = 1
let g:tex_flavor = 'latex'
let g:is_bash = 1
set number
let g:lua_tree_auto_close = 1 

" set termguicolors
" let g:gruvbox_contrast_dark = 'hard'
" let g:gruvbox_contrast_light = 'hard'
" colorscheme gruvbox

" highlight OverLength ctermbg=red ctermfg=white
" match OverLength /\%81v.\+/

" LSP stuff
" https://github.com/neovim/nvim-lsp/issues/127
lua << EOF
-- require'nvim_lsp'.gopls.setup{{on_attach=on_attach}}
-- require'nvim_lsp'.gopls.setup{}
-- require'nvim_lsp'.pyls.setup{}
-- require'nvim_lsp'.bashls.setup{}
EOF

nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

autocmd Filetype python setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd Filetype go setlocal omnifunc=v:lua.vim.lsp.omnifunc

" speed up grep if available
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" plugins
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('auto_complete_delay', 500)
call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })
set completeopt="noselect"

" language specific
let g:man_hardwrap = 1
set cinoptions=l1
let g:go_fmt_command = "goimports"

augroup languages
    autocmd!
    autocmd Filetype c setlocal ts=8 noexpandtab
augroup END

func PasteWorkaround()
    :r ! wl-paste | tr -d "\r"
endfunc

func PasteFromTMUX()
    :r ! tmux show-buffer
endfunc

" autocommands
augroup convenience
    autocmd!
    " remember cursor position
    autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
                \ |   exe "normal! g`\""
                \ | endif
augroup END

nnoremap <silent> <leader>ts ma :keeppatterns %s/\s\+$//e<cr>:TrimNewlines<cr>`a
nnoremap <silent> k gk
nnoremap <silent> j gj
nnoremap <silent> <Up> gk
nnoremap <silent> <Down> gj
nnoremap <silent> <leader>f :FZF<cr>
nnoremap <silent> <leader>r :Rg<cr>
nnoremap <silent> <leader>b :Buffers<cr>
map <silent> <leader>y "+y
nnoremap <silent> <leader>p :call PasteWorkaround()<cr>
nnoremap <silent> <leader>pt :call PasteFromTMUX()<cr>
"
" vim-sandwich; use cl instead; it's the same.
nmap s <Nop>
xmap s <Nop>

" Trash Ex mode.
nnoremap Q <Nop>

" TODO: to be the default int the future
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
