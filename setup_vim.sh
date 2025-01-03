# 1. Create or override ~/.vimrc
cat << 'EOF' > "${HOME}/.vimrc"
set number          
set rnu            
set cursorline      
set mouse=a        
set clipboard=unnamed   
set laststatus=2    
set showcmd        
set noshowmode      
set showmatch      
set encoding=utf-8  
syntax enable       
EOF

# 2. Create the directory ~/.config/nvim (if it doesn't exist)
mkdir -p "${HOME}/.config/nvim"

# 3. Create a file nvim.init inside the newly created directory
cat << 'EOF' > "${HOME}/.config/nvim/init.vim"
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
EOF

echo "Vim and Neovim configuration files have been successfully created/updated."
