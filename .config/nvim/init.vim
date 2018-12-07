call plug#begin('~/.local/share/nvim/plugged')
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go' }
Plug 'tomtom/tcomment_vim'
call plug#end()

" settings
set autowrite
set tabstop=4
set shiftwidth=0
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

" theme
let python_highlight_all = 1
let g:tex_flavor = 'latex'
let g:is_bash = 1
set number
set background=dark
" set termguicolors

" speed up grep if available
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" language specific
let g:go_fmt_command = "goimports"

" functions
function! TrimWhitespace() range
    for lineno in range(a:firstline, a:lastline)
        let line = getline(lineno)
        let clean_line = substitute(line, '\s\+$', '', 'e')
        call setline(lineno, clean_line)
    endfor
endfunction

function! TrimNewlines()
    " http://stackoverflow.com/a/7496112/2587286
    if line('$') > 1
        %s/\($\n\)\+\%$//e
    endif
endfunction

" commands
command! -range TrimWhitespace <line1>,<line2> call TrimWhitespace()
command! TrimNewlines call TrimNewlines()

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

" TODO: to be the default int the future
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
