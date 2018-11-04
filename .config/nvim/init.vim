" set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" More natural splits
set splitbelow
set splitright

set list
set smartcase
set mouse=a

" Theme
let python_highlight_all = 1
let g:tex_flavor = 'latex'
let g:is_bash = 1
set number
set background=dark

" Fix Hexmensch Foo with softwrap.
nnoremap <silent> k gk
nnoremap <silent> j gj

" TODO: to be the default int the future
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
