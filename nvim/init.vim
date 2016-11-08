"
syntax enable

set number
set cursorline
set title
set ruler
set nofoldenable
set noswapfile
set nobackup
set autoindent
set nojoinspaces
set ttyfast
set gdefault
set hidden
set ignorecase
set smartcase
set hlsearch
set incsearch
set nowrapscan
set noerrorbells
set visualbell
set t_vb=
set scrolloff=8
set laststatus=2
set backspace=indent,eol,start
set nostartofline
set noshowmode
set showcmd
set list
set listchars=tab:▸\ ,eol:¬
set history=256
set undodir=~/.config/nvim/undo undolevels=256
set undofile
set clipboard+=unnamedplus


"
let mapleader = ','

nnoremap ; :
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
nnoremap <Space> jzz
nnoremap <S-Space> kzz
nnoremap <C-b>c :bd<CR>
nnoremap <C-b>n :enew
nnoremap <TAB> :bn<CR>
nnoremap <S-TAB> :bp<CR>
nnoremap <Leader><Leader> :up<CR>
inoremap jj <ESC>
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv


"
let s:dein_dir = expand('~/.config/nvim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  let s:toml = expand('~/.config/nvim/dein.toml')
  let s:lazy_toml = expand('~/.config/nvim/dein_lazy.toml')

  call dein#begin(s:dein_dir, [s:toml, s:lazy_toml])

  if filereadable(s:toml)
    call dein#load_toml(s:toml, {'lazy': 0})
  endif

  if filereadable(s:lazy_toml)
    call dein#load_toml(s:lazy_toml, {'lazy': 1})
  endif

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
