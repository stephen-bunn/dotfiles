" Enable line numbers
set nu rnu

" Enable truecolor for terminals with truecolor support
set termguicolors

" Set the GUI font if running in neovim gui
set guifont="FiraCode Nerd Font Mono:h15"

" Set column break
set colorcolumn=88

" Set shell to bash
set shell=/bin/bash

" Set how many lines of history vim has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Fast exiting
nmap <leader>q :q<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" More natural splitting
set splitbelow
set splitright

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the wild menu
set wildmenu

" Ignore compiled files
if has("win16") || has("win32")
set wildignore+=.git\*,.hg\*,.svn\*
else
set wildignore+=*/.git*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Add a bit of extra margin to the left
set foldcolumn=2

" Enable syntax highlighting
syntax enable
set background=dark

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai " Auto indent
set si " Smart indent
set wrap " Wrap lines

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Useful mappings for managing windows
noremap <C-A-w> <C-W><C-c>
noremap <C-A-n> :vsp<cr>
noremap <C-A-m> :sp<cr>
noremap <C-A-j> <C-W><C-j>
noremap <C-A-k> <C-W><C-k>
noremap <C-A-h> <C-W><C-h>
noremap <C-A-l> <C-W><C-l>

" Useful mappings for managing buffers
noremap <C-j> :bprevious<cr>
noremap <C-k> :bnext<cr>
noremap <C-n> :enew<cr>
noremap <C-w> :Bclose<cr>:tabclose<cr>gT

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>t1 :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/k

" Switch CMD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Always show the status line
set laststatus=2

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

""" HELPER FUNCTIONS

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction
"
" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


""" PLUGINS

call plug#begin(stdpath('data') . '/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'gabrielelana/vim-markdown'
Plug 'editorconfig/editorconfig-vim'
Plug 'raimondi/delimitmate'
Plug 'ryanoasis/vim-devicons'
Plug 'mcchrish/nnn.vim'
Plug 'dense-analysis/ale'
Plug 'vimwiki/vimwiki'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'junegunn/goyo.vim'
Plug 'reedes/vim-pencil'

if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
end

Plug 'deoplete-plugins/deoplete-jedi'

call plug#end()

let g:deoplete#enable_at_startup = 1
let g:spacegray_use_italics = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_theme = 'dracula'
let g:airline_powerline_fonts = 1

" nnn Configuration
let g:nnn#layout = { 'window': { 'width': 0.5, 'height': 0.6, 'highlight': 'Debug' } }

" Jump completions via tab in deocomplete
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ deoplete#manual_complete()

function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~ '\s'
endfunction"}}}

" Dracula Pro
let g:dracula_colorterm = 0

" Set colorscheme
colorscheme dracula

" Color overrides
highlight ColorColumn ctermbg=Black guibg=#454158
highlight Pmenu ctermfg=NONE ctermbg=Black guibg=#454158 guifg=#f8f8f2
highlight PmenuSel ctermfg=NONE ctermbg=Blue guibg=#9580ff guifg=#f8f8f2
highlight PmenuSbar ctermfg=NONE ctermbg=Black guibg=#454159 guifg=NONE
highlight PmenuThumb ctermfg=NONE ctermbg=Blue guibg=#7970a9 guifg=NONE

" Prose configuration
function! Prose(bang)
    let proseWidth = 88
    
    if a:bang
        if exists('#goyo')
            call goyo#execute(!0, proseWidth)
        endif
        call pencil#init({'wrap': 'off'})
    else
        call pencil#init({'wrap': 'hard', 'textwidth': proseWidth, 'autoformat': 1})
        call goyo#execute(0, proseWidth + 2)
    end
endfunction

command! -nargs=0 -bang Prose call Prose(<bang>0)
