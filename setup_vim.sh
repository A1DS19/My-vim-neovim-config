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
call plug#begin()

Plug 'nanotech/jellybeans.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

set number          " Show line numbers
set rnu             " Show relative line numbers
set cursorline      " Highlight current line
set mouse=a         " Enable mouse
set clipboard=unnamed   " Use the system clipboard
set laststatus=2    " Always display status line
set showcmd         " Display incomplete commands
set noshowmode      " Don't show mode (like --INSERT--)
set showmatch       " Highlight matching bracket briefly
set encoding=utf-8  " Use UTF-8 encoding
syntax enable       " Enable syntax highlighting

colorscheme jellybeans

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='onedark'

nnoremap <C-t> :NERDTreeToggle<CR>
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p

:CocInstall coc-json coc-tsserver coc-prettier coc-rust-analyzer


let g:rustfmt_autosave = 1
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

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

