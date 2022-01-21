" Why do i even have to do this bruhhhhhhhhhhhhHHh i fucking went insane trying to figure this out
source /usr/share/vim/vim82/defaults.vim

" vundle configuration shit
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'valloric/youcompleteme'
Plugin 'chriskempson/base16-vim'
call vundle#end()
filetype plugin indent on

" Ycm config
set updatetime=1500
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_show_diagnostics_ui = 0
hi Pmenu ctermbg=236 ctermfg=7

set shiftwidth=4
set tabstop=4

" Change the cursor to a bar in insert and replace mode
let &t_SI = "\e[5 q"
let &t_EI = "\e[1 q"

" Delete whole file by ctrl+x
map <C-x> <esc>ggdG<CR>

" Theme customization
" set termguicolors
colorscheme base16-ashes
set cursorline
set number
highlight clear LineNr
highlight clear CursorLineNr
highlight clear CursorLine
highlight Normal guibg=NONE ctermbg=NONE
highlight CursorLineNr term=bold cterm=none ctermbg=none ctermfg=252
highlight CursorLine cterm=NONE ctermbg=236 ctermfg=NONE
highlight LineNr ctermfg=darkgrey

" Move lines up or down by alt j-k, fucking hell it doesnt work
" nnoremap <A-j> :m +1<CR>
" nnoremap <A-k> :m -2<CR>
" inoremap <A-j> <Esc>:m +1<CR>
" inoremap <A-k> <Esc>:m -2<CR>
" vnoremap <A-j> :m '>+1<CR>
" vnoremap <A-k> :m '<-2<CR>
