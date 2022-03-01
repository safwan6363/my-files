" Why do i even have to do this bruhhhhhhhhhhhhHHh i fucking went insane trying to figure this out
source /usr/share/vim/vim82/defaults.vim

" vundle configuration shit
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Plugin 'valloric/youcompleteme'
" Plugin 'chriskempson/base16-vim'
Plugin 'w0ng/vim-hybrid'
call vundle#end()
filetype plugin indent on

" Extreme undofile setup so i don't lose undoes even after closing the file
set undofile
set undodir=~/.vim/undofiles
set undolevels=10000

" Ycm config
" set updatetime=1500
" let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_show_diagnostics_ui = 0

set shiftwidth=4
set tabstop=4

" Change the cursor to a bar in insert and replace mode
let &t_SI = "\e[5 q"
let &t_EI = "\e[1 q"

" Delete whole file by ctrl+x
map <C-x> <esc>ggdG<CR>

" Colors and visual customization
" set termguicolors
set background=dark
colorscheme hybrid
set cursorline
set number
"ughok " clear background in line numbers and set custom ones
"ughok highlight clear LineNr
highlight LineNr ctermfg=darkgrey
"ughok highlight clear CursorLineNr
"ughok highlight CursorLineNr term=bold cterm=none ctermbg=none ctermfg=252
"ughok " The long cursor line highlight
"ughok highlight clear CursorLine
"ughok highlight CursorLine cterm=NONE ctermbg=236 ctermfg=NONE
"ughok " Menu for youcompleteme
"ughok highlight clear Pmenu
"ughok highlight Pmenu ctermbg=236 ctermfg=7
" Make the vim background color transparent
highlight Normal guibg=NONE ctermbg=NONE

" Move lines up or down by alt j-k, fucking hell it doesnt work
" nnoremap <A-j> :m +1<CR>
" nnoremap <A-k> :m -2<CR>
" inoremap <A-j> <Esc>:m +1<CR>
" inoremap <A-k> <Esc>:m -2<CR>
" vnoremap <A-j> :m '>+1<CR>
" vnoremap <A-k> :m '<-2<CR>
