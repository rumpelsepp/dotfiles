call plug#begin('~/.local/share/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }, | Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'

" Completion
" Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neco-syntax', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
Plug 'zchee/deoplete-clang', { 'for': 'c' }
Plug 'zchee/deoplete-go', { 'for': 'go', 'do': 'make' }
Plug 'sebastianmarkow/deoplete-rust', { 'for': 'rust' }
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'

Plug 'fatih/vim-go', { 'for': 'go' }

Plug 'matze/vim-move'
Plug 'tpope/vim-surround'

Plug 'scrooloose/nerdcommenter'
Plug 'Raimondi/delimitMate'

Plug 'scrooloose/nerdtree' | Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
" Plug 'machakann/vim-highlightedyank'
Plug 'rumpelsepp/neovim-gitignore', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-fugitive'

Plug 'editorconfig/editorconfig-vim'

Plug 'sheerun/vim-polyglot'
Plug 'lervag/vimtex', { 'for': 'tex' }

Plug 'rakr/vim-one'
Plug 'mhartington/oceanic-next'
Plug 'iCyMind/NeoSolarized'
" Plug 'morhetz/gruvbox'
call plug#end()

" Plugin Settings
" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-3.8/lib/libclang.so.1'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#omni#input_patterns.tex = '\\(?:'
    \ . '\w*cite\w*(?:\s*\[[^]]*\]){0,2}\s*{[^}]*'
    \ . '|\w*ref(?:\s*\{[^}]*|range\s*\{[^,}]*(?:}{)?)'
    \ . '|hyperref\s*\[[^]]*'
    \ . '|includegraphics\*?(?:\s*\[[^]]*\]){0,2}\s*\{[^}]*'
    \ . '|(?:include(?:only)?|input)\s*\{[^}]*'
    \ . '|\w*(gls|Gls|GLS)(pl)?\w*(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
    \ . '|includepdf(\s*\[[^]]*\])?\s*\{[^}]*'
    \ . '|includestandalone(\s*\[[^]]*\])?\s*\{[^}]*'
    \ . ')'

" vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let delimitMate_expand_cr=1

" highlightedyank
let g:highlightedyank_highlight_duration = 150

" Airline
let g:airline_symbols_ascii = 1
let g:airline#extensions#whitespace#enabled = 0

" NERDCommenter
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDDefaultAlign = 'left'
let g:NERDTrimTrailingWhitespace = 1
" https://github.com/scrooloose/nerdcommenter/issues/202
let g:NERDCustomDelimiters = {'python': {'left': '#'}}
let g:NERDCustomDelimiters = {'c': {'left': '//'}}

" let g:NERDTreeShowIgnoredStatus = 1

imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" Close the documentation window when completion is done
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" Misc
set undofile
"
" More natural splits
set splitbelow
set splitright

" Show invisibles
set list
set listchars=""
set listchars=tab:>-
set listchars+=eol:¬
set listchars+=trail:·
set listchars+=extends:>
set listchars+=precedes:<

" Search
set ignorecase
set smartcase
set magic
set inccommand=nosplit
set redrawtime=200

set completeopt-=preview

" https://neovim.io/doc/user/nvim_terminal_emulator.html#nvim-terminal-emulator-input
tnoremap <Esc> <C-\><C-n>

" Fix Johannes Foo with softwrap.
nnoremap <silent> k gk
nnoremap <silent> j gj

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  autocmd!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   execute "normal! g`\"" |
    \ endif
augroup END

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" http://vi.stackexchange.com/a/456
function! TrimWhitespace()
    let l:_s = @/
    let l:save_cursor = getpos('.')
    %s/\s\+$//e
    " http://stackoverflow.com/a/7496112/2587286
    if line('$') > 1
        %s/\($\n\)\+\%$//e
    endif
    let @/ = l:_s
    call setpos('.', l:save_cursor)
endfunction
autocmd BufWritePre * call TrimWhitespace()
command! TrimWhitespace call TrimWhitespace()

autocmd FileType c,h,go set softtabstop=8 shiftwidth=8 noexpandtab

nnoremap <space> a<space><esc>

" FZF mappings
noremap <Leader>g :GitFiles<CR>
noremap <Leader>f :Files<CR>
noremap <Leader>b :Buffers<CR>
noremap <Leader>a :Ag<space>

noremap <C-\> :NERDTreeToggle<CR>
noremap <Leader>; mZA;<Esc>`Z
nnoremap <Leader><cr> mZo<Esc>`Z
nnoremap <Leader><Leader><cr> mZO<Esc>`Z
nmap gc <Plug>NERDCommenterToggle
vmap gc <Plug>NERDCommenterToggle

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" https://github.com/neovim/neovim/issues/5219#issuecomment-239365013
autocmd filetype man nnoremap <buffer> q :q<CR>

" Theme and highlighting
if has("termguicolors")
    set termguicolors
else
    let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

let python_highlight_all = 1
let g:tex_flavor = 'latex'
set number
set cursorline
set background=dark
colorscheme one
let g:airline_theme='one'

" Make NERDTree the default filebrowser.
" http://stackoverflow.com/a/21687112
let loaded_netrwPlugin = 1

" FZF config
" Mapping selecting mappings
" " Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'
