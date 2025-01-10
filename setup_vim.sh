#!/usr/bin/env bash

# ------------------------------------------------
# 1. Install vim-plug for Vim
# ------------------------------------------------
echo "Installing vim-plug for Vim..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# ------------------------------------------------
# 2. Install vim-plug for Neovim
# ------------------------------------------------
echo "Installing vim-plug for Neovim..."
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# ------------------------------------------------
# 3. Create/override ~/.vimrc
# ------------------------------------------------
echo "Creating ~/.vimrc..."
cat << 'EOF' > "${HOME}/.vimrc"
" Initialize vim-plug
call plug#begin('~/.vim/plugged')

" **Color Scheme**
Plug 'nanotech/jellybeans.vim'

" **Status Line**
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" **File Explorer**
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'scrooloose/nerdtree-project-plugin'

" **Navigation Enhancements**
Plug 'christoomey/vim-tmux-navigator'

" **Auto Pairing**
Plug 'jiangmiao/auto-pairs'

" **Code Commenting**
Plug 'tpope/vim-commentary'

" **Language Server Protocol (LSP) and Autocompletion**
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" **Optional: Gutentags for Automatic Tag Generation**
" Plug 'ludovicchabant/vim-gutentags'

call plug#end()

" -------------------------------
" **Basic Settings**
" -------------------------------

set number                 " Show absolute line numbers
set relativenumber         " Show relative line numbers
set cursorline             " Highlight current line
set mouse=a                " Enable mouse support
set clipboard=unnamed      " Use the system clipboard
set laststatus=2           " Always display the status line
set showcmd                " Display incomplete commands
set noshowmode             " Don't show mode (like --INSERT--)
set showmatch              " Highlight matching brackets
set encoding=utf-8         " Use UTF-8 encoding
syntax enable              " Enable syntax highlighting

" -------------------------------
" **Color Scheme**
" -------------------------------
colorscheme jellybeans

" -------------------------------
" **Vim-Airline Configuration**
" -------------------------------
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'onedark'

" -------------------------------
" **NERDTree Configuration**
" -------------------------------

" Toggle NERDTree with Ctrl + t
nnoremap <C-t> :NERDTreeToggle<CR>

" Automatically open NERDTree on Vim start and focus on the last window
autocmd VimEnter * NERDTree | wincmd p

" Mirror NERDTree when opening new buffers
autocmd BufWinEnter * if &buftype != 'quickfix' && getcmdwintype() == '' | silent NERDTreeMirror | endif

let NERDTreeShowHidden=1

" -------------------------------
" **CoC.nvim Configuration**
" -------------------------------

" Use <Tab> and <S-Tab> for navigating completion menu
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"

" Accept completion with Enter key
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Key mappings for CoC
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Show documentation with K
nnoremap <silent> K :call CocAction('doHover')<CR>

" Highlight symbol and references on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Format current buffer
nmap <silent> <leader>f :call CocAction('format')<CR>

" Trigger code actions
nmap <silent> <leader>ca :CocCommand editor.action.codeAction<CR>

" Rust specific settings
let g:rustfmt_autosave = 1

" -------------------------------
" **Optional: Gutentags Configuration**
" -------------------------------
" If you chose to install vim-gutentags, uncomment and configure as needed
" let g:gutentags_enabled = 1
" let g:gutentags_project_root = ['.git', 'package.json', 'pyproject.toml', 'Cargo.toml', 'go.mod']

" -------------------------------
" **Additional Plugins and Settings**
" -------------------------------

" Add any additional plugins below
" Plug 'plugin/name'

" -------------------------------
" **Buffer Navigation Mappings**
" -------------------------------

" Map 'bn' to go to the next buffer
nnoremap bn :bnext<CR>

" Map 'bp' to go to the previous buffer
nnoremap bp :bprevious<CR>

" -------------------------------
" **Languages configuration**
" -------------------------------
let g:coc_global_extensions = [
  \ 'coc-json',
  \ 'coc-tsserver',
  \ 'coc-prettier',
  \ 'coc-rust-analyzer',
  \ 'coc-python',
  \ 'coc-omnisharp'
  \ ]

" -------------------------------
" **End of Configuration**
" -------------------------------

EOF

# ------------------------------------------------
# 4. Create ~/.config/nvim/init.vim
#    (Neovim's main configuration file)
# ------------------------------------------------
echo "Setting up Neovim configuration..."
mkdir -p "${HOME}/.config/nvim"
cat << 'EOF' > "${HOME}/.config/nvim/init.vim"
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
EOF

echo "Setup complete! vim-plug installed and configurations created."

