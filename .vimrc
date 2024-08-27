" useful keys : é, ù, £, §, ç 
" é, ù, ç is used

call plug#begin()
Plug('VundleVim/Vundle.vim')
Plug('tpope/vim-fugitive')
Plug('michaeljsmith/vim-indent-object')
"Plug('prabirshrestha/asyncomplete.vim')
"Plug 'prabirshrestha/vim-lsp'
"Plug 'mattn/vim-lsp-settings'
" For React : 
Plug 'yuratomo/w3m.vim'
Plug 'preservim/nerdtree'

call plug#end()
let g:NERDTreeQuitOnOpen = 1
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting
"Plugin
syntax on 
" for auto save after the buffer leaved
set autowrite
set cursorcolumn cursorline
"hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white
"hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white
"---------------------------------------------------------------------------"
"
set clipboard=unnamed
map é :tabe<CR>
map ù <leader>
map ùù <leader><leader>
map ç :bd<CR>
map ¥ <leader>
map ¥¥ <leader><leader>
noremap <space> <C-w>
noremap <leader>v :e ~/.vimrc<CR>
nnoremap <leader>d "=strftime("%d/%m/%y %H:%M:%S")<CR>P

" CLINK REMAP 
noremap <leader>a :e assets/elements/files/
noremap <leader>l :e assets/lang/
noremap <leader>t :e src/test_case/test/
noremap <leader>p :e src/pages/
noremap <leader>s :call Switch_lang_files()<CR>
nnoremap <CR> :call SaveAndRunPython()<CR>
nnoremap <Tab> :b 
" nnoremap <Tab> :bnext<CR>
" nnoremap <S-Tab> :bprevious<CR>
set wildchar=<Tab> wildmenu wildmode=full
function! LocalesComplete(lead, cmdline, cursorpos)
    " Liste des locales pour toutes les régions
    let locales = [
    \ 'germany', 'switzerland', 'france', 'italy', 'united_arab_emirates', 'united_kingdom', 'england', 'japan', 'taiwan', 'china',
    \ 'belgium', 'canada', 'mexico', 'singapore', 'hong_kong', 
    \ ]
    " Filtrer les locales en fonction du préfixe entré par l'utilisateur
    return filter(copy(locales), 'v:val =~ "^" . a:lead')
endfunction

function! Switch_lang_files()
    let locales = [
    \ 'germany', 'switzerland', 'france', 'italy', 'united_arab_emirates', 'united_kingdom', 'england', 'japan', 'taiwan', 'china',
    \ 'belgium', 'canada', 'mexico', 'singapore', 'hong_kong', 
    \ ]
    let userLocale = input('Entrez un pays (ex: france): ', '', 'customlist,LocalesComplete')
    if index(locales, userLocale) != -1
        let currentFilePath = expand('%:p')
        let regionPath = 'test'
        if index(['japan', 'taiwan', 'hong_kong', 'china', 'singapore'], userLocale) >= 0
            let regionPath = 'APAC'
        elseif index(['mexico', 'canada'], userLocale) >= 0
            let regionPath = 'AMER'
        elseif index(['france', 'italy', 'germany', 'switzerland', 'united_kingdom', 'belgium'], userLocale) >= 0
            let regionPath = 'EMEA'
        endif
        let newPath = substitute(currentFilePath, 'src/test_case/test/', 'src/test_case/'.regionPath.'/'.userLocale.'/custom/', '')
	let dirPath = fnamemodify(newPath, ':h')
	call mkdir(dirPath, 'p')
	execute 'edit ' . newPath
    else
        echo 'Pays non reconnu ou non supporté.'
    endif
endfunction
" Lier la fonction à une commande pour faciliter son utilisation
function! SaveAndRunPython()
    wa
    if &filetype == 'python'
        clear
        if matchstr(expand('%:t'), '^test') != ''
            !pytest -rP %
        else
            !python3 %
        endif
    elseif &filetype == 'yml' || &filetype == 'yaml'
        clear
        !yq %
    elseif &filetype == 'html'
        !open -a firefox %
    elseif &filetype == 'cpp'
        !g++ -o %< % && ./%<
    else
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
