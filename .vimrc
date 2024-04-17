" Vundle configuration
set nocompatible              " be iMproved, required
filetype off                  " required
"---------------------------------------------------------------------------"
call plug#begin()
Plug('VundleVim/Vundle.vim')
Plug('tpope/vim-fugitive')
Plug('michaeljsmith/vim-indent-object')
"Plug('prabirshrestha/asyncomplete.vim')
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
" For React : 
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'
Plug 'yuratomo/w3m.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'

let g:coc_global_extensions = [
  \ 'coc-tsserver'
  \ ]
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting
"Plugin
syntax on 
"---------------------------------------------------------------------------"
set clipboard=unnamed
let mapleader=" "
noremap <F13> <C-w>
"---------------------------------------------------------------------------"
"Entrée lance un test python
function! SaveAndRunPython()
    " Vérifie si le fichier courant est un fichier Python
    if &filetype == 'python'
        " Sauvegarde le fichier
        write
	clear
        " Exécute le fichier Python courant
	!pytest -rP %
        " Simule simplement un appui sur Entrée dans le cas contraire
        execute "normal! \<CR>"
    elseif &filetype == 'yml' || &filetype == 'yaml'
        " Sauvegarde le fichier
        write
	8clear
        " Exécute le fichier Python courant
        !yq %
    else
        " Simule simplement un appui sur Entrée dans le cas contraire
        execute "normal! \<CR>"
    endif
endfunction
"---------------------------------------------------------------------------"
" Mappage de la touche Entrée en mode normal
nnoremap <CR> :call SaveAndRunPython()<CR>

let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
" One char motion nmap is for every windows of vim
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
"nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
 autocmd BufWinEnter *.py nmap <silent> <F5>:w<CR>:terminal python3 -m pdb '%:p'<CR> 

noremap <F1> <C-W>
" Nerd tree
nnoremap <F2> :NERDTreeToggle<CR>


let g:lsp_settings = {
\   'pylsp': {
\     'workspace_config': {
\       'pylsp': {
\         'plugins': {
\           'pycodestyle': {
\             'ignore': ["E221", "E501","E302", "W291", "E225", "E275", "E231", "E123", "E203", "W503"]
\           }
\         }
\       }
\     }
\   },
\}

" VIM GPT
let g:chat_gpt_max_tokens=2000
let g:chat_gpt_model='gpt-4-turbo-preview'
let g:chat_gpt_session_mode=0
let g:chat_gpt_temperature = 0.7
let g:chat_gpt_lang = 'English'
let g:chat_gpt_split_direction = 'vertical'
