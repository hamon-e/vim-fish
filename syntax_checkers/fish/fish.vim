if exists('g:loaded_syntastic_fish_fish_checker')
    finish
endif
let g:loaded_syntastic_fish_fish_checker = 1

let s:save_cpo = &cpo
set cpo&vim

function! SyntaxCheckers_fish_fish_IsAvailable() dict
    return executable(self.getExec())
endfunction

function! SyntaxCheckers_fish_fish_GetLocList() dict
    let makeprg = self.makeprgBuild({'args': '--no-execute'})

    let errorformat =  '%f (line %l):%m'

    return SyntasticMake({ 'makeprg': makeprg, 'errorformat': errorformat})
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
            \ 'filetype' : 'fish',
            \ 'name'     : 'fish',
            \ 'exec'     : 'fish'})

let &cpo = s:save_cpo
unlet s:save_cpo
