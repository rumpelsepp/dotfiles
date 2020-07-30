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
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'dense-analysis/ale'
" Plug 'davidhalter/jedi-vim'
" Plug 'kyazdani42/nvim-tree.lua'
" Plug 'sheerun/vim-polyglot'
" Plug 'tpope/vim-surround'
" Plug 'cohama/lexima.vim'
" Plug 'tpope/vim-fugitive'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'nvim-lua/completion-nvim'
Plug 'neovim/nvim-lsp'
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
set signcolumn=yes

" theme
let python_highlight_all = 1
let g:tex_flavor = 'latex'
let g:is_bash = 1
set number

" set termguicolors

" highlight OverLength ctermbg=red ctermfg=white
" match OverLength /\%81v.\+/

" LSP stuff
" https://github.com/neovim/nvim-lsp/issues/127
lua << EOF
-- require'nvim_lsp'.gopls.setup{}
-- require'nvim_lsp'.pyls.setup{}
-- require'nvim_lsp'.bashls.setup{}
EOF
augroup LuaHighlight
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

" nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
" nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
" nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
" nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
"
" autocmd Filetype python setlocal omnifunc=v:lua.vim.lsp.omnifunc
" autocmd Filetype go setlocal omnifunc=v:lua.vim.lsp.omnifunc

" speed up grep if available
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" plugins
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('auto_complete_delay', 500)
" call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })
set completeopt="noselect"
" set completeopt=menuone,noinsert,noselect
set shortmess+=c

nmap <silent> <leader>l <Plug>(ale_previous_wrap)
nmap <silent> <leader>a <Plug>(ale_next_wrap)
nmap <silent> <F5> <Plug>(ale_previous_wrap)
nmap <silent> <F6> <Plug>(ale_next_wrap)
nmap <F8> <Plug>(ale_fix)
nmap <leader>af <Plug>(ale_fix)
nmap K <Plug>(ale_hover)
nmap gr <Plug>(ale_find_references)
nmap gd <Plug>(ale_go_to_definition)
nmap gD <Plug>(ale_go_to_type_definition)
nmap <F12> <Plug>(ale_go_to_definition)

let g:ale_linters = {
      \   'go': ['gopls'],
      \   'python': ['flake8', 'mypy', 'pyls'],
      \}
let g:ale_fixers = {
      \   'go': ['goimports'],
      \}
" Avoid conflicts with flake8 linter
let g:ale_python_pyls_config = {
    \ 'pyls': {
    \   'plugins': {
    \       'pycodestyle': {'enabled': v:false},
    \       'mccabe': {'enabled': v:false},
    \       'pyflakes': {'enabled': v:false},
    \   }
    \  }
    \ }

" language specific
let g:man_hardwrap = 1
set cinoptions=l1

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
