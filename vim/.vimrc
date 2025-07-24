syntax on

set background=dark
set cmdheight=1
set completeopt=menu,menuone,noselect
set conceallevel=3
set confirm
set cursorline
set expandtab
set ignorecase
set laststatus=2
set mouse=a
set number
set numberwidth=1
" set omnifunc=
set pumheight=10
set relativenumber
set scrolloff=8
set shiftwidth=4
set showcmd
set showmode
set showtabline=2
set sidescroll=3
set sidescrolloff=3
set signcolumn=yes
set nosmartcase
set smartindent
set smoothscroll
set nospell
" set spelllang
set splitbelow
set splitright
set noswapfile
set tabstop=4
set termguicolors
set timeoutlen=800
set noundofile
set undolevels=10000
set updatetime=200
set virtualedit=block
set nowrap

let g:mapleader = " "

inoremap jk <esc>

nmap <c-h> <c-w>h
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k
nmap <c-l> <c-w>l

nmap <c-Up> :silent resize -2<cr>
nmap <c-Down> :silent resize +2<cr>
nmap <c-Left> :silent vertical resize -2<cr>
nmap <c-Right> :silent vertical resize +2<cr>

nmap <leader>bd :bd!<cr>

nmap <c-n> :Lexplore 30<cr>

nmap <leader>nh :nohlsearch<cr>

nmap <c-a> gg<s-v>G

map <leader>y "+y

colorscheme habamax
