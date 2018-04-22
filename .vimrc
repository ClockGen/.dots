"----------------------
"Vundle initialization" 
set nocompatible
filetype off
set rtp+=~/.dots/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
"----------------------

"Vundle Plugin List"
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'jiangmiao/auto-pairs'
Plugin 'alvan/vim-closetag'
Plugin 'L9'
Plugin 'AutoComplPop'
Plugin 'MarcWeber/vim-addon-mw-utils' 
Plugin 'tomtom/tlib_vim' 
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'liuchengxu/space-vim-dark'
Plugin 'flazz/vim-colorschemes'
Plugin 'mhinz/vim-signify'
Plugin 'mbbill/undotree'
Plugin 'chrisbra/csv.vim'
Plugin 'jreybert/vimagit'
Plugin 'vim-syntastic/syntastic'
Plugin 'yegappan/mru'
Plugin 'junegunn/goyo.vim'
Plugin 'jlanzarotta/bufexplorer'
"Plugins should be specified before this line"
call vundle#end()
filetype plugin indent on
"----------------------

"General Vim Settings"
set encoding=utf-8
set nowrap
set number
syntax on
set foldmethod=syntax
set noshowmode
set showtabline=2
set laststatus=2
set mouse=a
"----------------------

"Mappings"
nmap n :NERDTreeToggle<CR>
nmap y :UndotreeToggle<CR>
nmap g :Goyo<CR>
nmap o :MRU<CR>
nmap m :Magit<CR>
nmap <S-q> :q!<CR>
nmap q :q<CR>
nmap <S-w> :w<CR>
noremap e za<CR>
nmap <S-e> zR<CR>
nmap <M-e> zM<CR>
"----------------------

"Omnitype Settings"
filetype plugin on 
set omnifunc=syntaxcomplete#Complete 
"----------------------

"General and plugin theming"
"colorscheme space-vim-dark
let g:airline_theme='tomorrow'
hi Comment cterm=italic
hi Normal ctermbg=none
hi Folded ctermbg=251
"----------------------

"Nerd Tree settings
let NERDTreeShowHidden=1
"----------------------

"Airline settings
let g:airline#extensions#tabline#enabled = 1
"Uncomment to use powerline fonts
"let g:airline_powerline_fonts = 1
let g:airline_symbols_ascii = 1  
" Disables error section
"let g:airline_section_error=''
let g:airline_section_warning=''
let g:airline#extensions#default#section_truncate_width = {
      \ 'a': 0,
      \ 'b': 0,
      \ 'c': 0,
      \ 'gutter': 0,
      \ 'x': 0,
      \ 'y': 0,
      \ 'z': 45,
      \ 'warning': 80,
      \ 'error': 80,
      \ }
"----------------------

"Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
"----------------------

"MRU settings
let MRU_Max_Entries = 1000
let MRU_Window_Height = 5
let MRU_Auto_Close = 0
let MRU_Add_Menu = 0
let MRU_Max_Menu_Entries = 20
"----------------------

