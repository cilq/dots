call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
autocmd! bufwritepost .vimrc source %
set laststatus=2
set t_Co=256
color smyck
