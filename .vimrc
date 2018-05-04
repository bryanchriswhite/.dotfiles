syntax on
filetype plugin indent on
set tabstop=2
set shiftwidth=2
set expandtab
set nu

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

execute pathogen#infect()

" How can I open a NERDTree automatically when vim starts up?
autocmd vimenter * NERDTree

" How can I open a NERDTree automatically when vim starts up if no files were specified?
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" NERDTree hotkey
map <C-n> :NERDTreeToggle<CR>

" Quit if NERDTree is the only window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
