" auto-install vim-plug                                                                                                                
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'joshdick/onedark.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'neomake/neomake'
Plug 'tpope/vim-fugitive'
Plug 'bling/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'https://github.com/vim-scripts/tComment.git'
Plug 'https://github.com/kien/ctrlp.vim.git'
Plug 'https://github.com/jeetsukumaran/vim-buffergator.git'
Plug 'https://github.com/tpope/vim-sensible.git'
Plug 'https://github.com/altercation/vim-colors-solarized.git'
call plug#end()

set t_Co=256
set bg=dark
set ts=4
set expandtab
set shiftwidth=4
set smartindent
set number
set laststatus=2
set timeoutlen=1000
set ttimeoutlen=50
set termguicolors

filetype plugin indent on

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_left_sep=''
let g:airline_right_sep=''

colorscheme onedark

map <C-n> :NERDTreeToggle<CR>
map <C-b> :BuffergatorToggle<CR>
map <Leader>r :vert res 81<CR>
map <Leader>l :LengthmattersToggle<CR>
vmap <Leader>C :TCommentBlock<CR>
vmap <Leader>c :TComment<CR>

let g:buffergator_suppress_keymaps=1

let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

autocmd BufReadPre SConstruct set filetype=python
autocmd BufReadPre SConscript set filetype=python
autocmd! BufWritePost,BufEnter * Neomake

"F403 - ignore import * errors
"E401 - ignore multiple imports
"E128 - ignore indent lines to opening parentheses
let g:neomake_python_flake8_maker = {
    \ 'args': ['--ignore=E401,F403,E128',  '--format=default', '--max-line-length=80'],
    \ 'errorformat':
        \ '%E%f:%l: could not compile,%-Z%p^,' .
        \ '%A%f:%l:%c: %t%n %m,' .
        \ '%A%f:%l: %t%n %m,' .
        \ '%-G%.%#',
    \ }

let g:neomake_python_enabled_makers = ['flake8']
" let g:neomake_warning_sign = {
"   \ 'text': 'S>',
"   \ 'texthl': 'WarningMsg',
"   \ }

let g:neomake_error_sign = {
  \ 'text': 'X',
  \ 'texthl': 'ErrorMsg',
  \ }

function! NERDTreeQuit()
  redir => buffersoutput
  silent buffers
  redir END
"                     1BufNo  2Mods.     3File           4LineNo
  let pattern = '^\s*\(\d\+\)\(.....\) "\(.*\)"\s\+line \(\d\+\)$'
  let windowfound = 0

  for bline in split(buffersoutput, "\n")
    let m = matchlist(bline, pattern)

    if (len(m) > 0)
      if (m[2] =~ '..a..')
        let windowfound = 1
      endif
    endif
  endfor

  if (!windowfound)
    quitall
  endif
endfunction

autocmd WinEnter * call NERDTreeQuit()

let g:deoplete#sources#jedi#show_docstring = 0

let sim_docs = { 'path': '~/dev/cpp/sim/docs/source/',}
let g:riv_projects = [sim_docs]

let g:neomake_makedocs_maker = { 'exe': 'make', 'args': ['dirhtml'] }
let g:neomake_makeclean_maker = { 'exe': 'make', 'args': ['clean'] }
autocmd bufreadpre *.rst setlocal textwidth=80

if $VIM_CRONTAB == "true"
    set nobackup
    set nowritebackup
endif
