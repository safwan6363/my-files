" Why do i even have to do this bruhhhhhhhhhhhhHHh i fucking went insane trying to figure this out
source /usr/share/vim/vim82/defaults.vim

" vundle configuration shit
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'valloric/youcompleteme'
call vundle#end()
filetype plugin indent on

" Ycm config
" let g:ycm_auto_hover = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_show_diagnostics_ui = 0
hi Pmenu ctermbg=236 ctermfg=7

set shiftwidth=4
set tabstop=4

" Change the cursor to a bar in insert and replace mode
let &t_SI = "\e[5 q"
let &t_EI = "\e[1 q"

" Delete whole file by ctrl+x
map <C-x> <esc>ggdG<CR>

" line highlighting and cursor good look ok
set cursorline
set number
highlight CursorLine cterm=NONE ctermbg=236 ctermfg=NONE
highlight CursorLineNr term=bold cterm=none ctermbg=none ctermfg=yellow
highlight LineNr ctermfg=darkgrey

" Move lines up or down by alt j-k, fucking hell it doesnt work
" nnoremap <A-j> :m +1<CR>
" nnoremap <A-k> :m -2<CR>
" inoremap <A-j> <Esc>:m +1<CR>
" inoremap <A-k> <Esc>:m -2<CR>
" vnoremap <A-j> :m '>+1<CR>
" vnoremap <A-k> :m '<-2<CR>
