" set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set smarttab
set undofile

" More natural splits
set splitbelow
set splitright

" Show invisibles
set list

" Search
set ignorecase
set smartcase
set magic
set inccommand=nosplit
set redrawtime=200

set mouse=a

" Theme
let python_highlight_all = 1
let g:tex_flavor = 'latex'
let g:is_bash = 1
set number
"set termguicolors
set background=dark

" Fix Hexmensch Foo with softwrap.
nnoremap <silent> k gk
nnoremap <silent> j gj

nnoremap <space> a<space><esc>
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

augroup autocmds
    autocmd!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78
    autocmd FileType c,h,go setlocal softtabstop=8 shiftwidth=8 noexpandtab

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    autocmd BufReadPost *
                \ if line("'\"") >= 1 && line("'\"") <= line("$") |
                \   execute "normal! g`\"" |
                \ endif

    " https://github.com/neovim/neovim/issues/5219#issuecomment-239365013
    autocmd filetype man nnoremap <buffer> q :q<CR>
augroup END

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
command! TrimWhitespace call TrimWhitespace()
