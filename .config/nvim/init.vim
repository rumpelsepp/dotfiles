call plug#begin('~/.local/share/nvim/plugged')
Plug 'tomtom/tcomment_vim'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'dag/vim-fish'
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdtree'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'tpope/vim-surround'
" Plug 'cohama/lexima.vim'
" Plug 'tpope/vim-fugitive'

" Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp'
" Plug 'prabirshrestha/asyncomplete.vim'
" Plug 'prabirshrestha/asyncomplete-lsp.vim'

" Plug 'neomake/neomake'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'deoplete-plugins/deoplete-jedi', {'for': 'python'}
" Plug 'Shougo/neosnippet.vim'
" Plug 'Shougo/neosnippet-snippets'
call plug#end()

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
set wrapmargin=2
set linebreak
set hidden
set signcolumn=yes

" theme
let python_highlight_all = 1
let g:tex_flavor = 'latex'
let g:is_bash = 1
set number
" set termguicolors
" highlight OverLength ctermbg=red ctermfg=white
" match OverLength /\%81v.\+/

" speed up grep if available
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" plugins
" let g:deoplete#enable_at_startup = 1
" call deoplete#custom#option('auto_complete_delay', 500)
" call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" language specific
let g:go_fmt_command = "goimports"
let g:man_hardwrap = 1

function! s:todo() abort
  let entries = []
  for cmd in ['git grep -niI -e TODO -e FIXME -e XXX 2> /dev/null',
            \ 'grep -rniI -e TODO -e FIXME -e XXX * 2> /dev/null']
    let lines = split(system(cmd), '\n')
    if v:shell_error != 0 | continue | endif
    for line in lines
      let [fname, lno, text] = matchlist(line, '^\([^:]*\):\([^:]*\):\(.*\)')[1:3]
      call add(entries, { 'filename': fname, 'lnum': lno, 'text': text })
    endfor
    break
  endfor

  if !empty(entries)
    call setqflist(entries)
    copen
  endif
endfunction
command! TODO call s:todo()

func PasteWorkaround()
    :r ! wl-paste | tr -d "\r"
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

" Trash Ex mode.
nnoremap Q <Nop>
nnoremap <silent> <leader>p :call PasteWorkaround()<cr>

" TODO: to be the default int the future
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
