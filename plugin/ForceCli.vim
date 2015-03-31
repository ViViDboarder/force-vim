" Config Variables {
if !exists("g:force_dispatch_background")
    let g:force_dispatch_background = 0
end

if !exists("g:force_disable_airline")
    let g:force_disable_airline = 0
end

if !exists("g:force_status_line_func_added")
    let g:force_status_line_func_added = 0
end
" Config Variables }

" Main Functions {

function! ForceDeploy()
    let filePath = expand("%")

    let command = "force push \"" . filePath . "\""
    call ForceTryStart(command)

endfunction

function! ForceTest()
    let fileName = expand("%:t:r")

    let command = "force test \"" . fileName ."\""
    call ForceTryStart(command)

endfunction

" function! ForceRetrieve()
"     let filePath = expand("%")
"
"     let command =
"     call ForceTryStart(command)
"
" endfunction

function! ForceActive(...)
    if a:0 > 0
        if a:1 == "?"
            let command = "force logins"
        else
            let target = a:1

            let command = "force active \"" . target . "\""
        end
    else
        let command = "force active"
    end

    if exists("l:command")
        call ForceTryStart(command)
    end

endfunction

function! ForceLogin(...)
    let command = "force login " . join(a:000, " ")
    call ForceTryStart(command)
endfunction

" Try to run the command using vim-dispatch
" (https://github.com/tpope/vim-dispatch)
function! ForceTryStart(...)

    " Make sure we have a parameter
    if a:0 > 0
        let command = a:1

        if exists(":Dispatch")
            " Determine foreground or background
            if g:force_dispatch_background == 1
                let fgbg = "! "
            else
                let fgbg = " "
            end

            let command =  "Dispatch" . fgbg . command
        else
            let command =  "!" . command
        end

        execute command
    end

endfunction

command! -nargs=0 ForceDeploy call ForceDeploy()         " Deploy current file
command! -nargs=0 ForceTest call ForceTest() " Deploy current file and run test
"command! -nargs=0 ForceRetrieve call ForceRetrieve()     " Retrieve current file
command! -nargs=? ForceLogin call ForceLogin(<f-args>)   " Retrieve current file
command! -nargs=? ForceTarget call ForceTarget(<f-args>) " Change deploy target

" Main Functions }

" Set SF Compiler
autocmd BufNewFile,BufRead *.cls,*.trigger,*.page,*.component compiler ForceCli

" Execute Anonymous {

" Run current buffer
" function! ForceRunCurrentBuffer()
"     let a=join(getline(1, '$'), "\\\n")
"     let cmd=join(["force apex <<END_APEX", a, "END_APEX"], "\\\n")
"     execute '!' . cmd
" endfunction

" Run current file
" function! ForceRunCurrentFile()
"     let anonapex=expand('%')
"     botright new
"     setlocal buftype=nofile bufhidden=wipe noswapfile nowrap filetype=apexlog
"     silent execute '$read ! force apex ' . anonapex
" endfunction

" function! ForceExecAnon()
"     let anonfile="~/.anon-apex"
"     execute 'botright edit ' . anonfile
"     setlocal filetype=apex makeprg="force apex"
" endfunction

function! ForceNewExecAnon()
    botright new AnonApex
    setlocal buftype=nofile bufhidden=wipe noswapfile filetype=apex
endfunction

" Run current file
function! ForceExecScratchAnon()
    " TODO: Check if buffer name is AnonApex
    " If not AnonApex, get current or selected lines and write to anonfile
    let anonfile="~/.anon-apex"
    silent execute 'w ' . anonfile
    " TODO: Test if log exists already
    botright new AnonApexLog
    setlocal buftype=nofile bufhidden=wipe noswapfile nowrap filetype=apexlog
    silent execute '$read ! force apex ' . anonfile
endfunction

command! -nargs=0 ForceNewExecAnon call ForceNewExecAnon()
command! -nargs=0 ForceExecScratchAnon call ForceExecScratchAnon()

" Execute Anonymous }

" Plugin Functions {

function! ForceCli#TargetName()
    " Returns the name of the current force.com target
    return system('force-target 2> /dev/null')[:-2]
endfunction

function! ForceCli#AirlineFunction(...)
    if &filetype == 'apex' || &filetype == 'visualforce'
        let force_target = ForceCli#TargetName()
        if force_target != ''
            call airline#extensions#append_to_section('b', ' ☁' . force_target)
        endif
    endif
endfunction

if g:force_disable_airline != 1 && g:loaded_airline == 1 && g:force_status_line_func_added != 1
    call airline#add_statusline_func('ForceCli#AirlineFunction')
    let g:force_status_line_func_added = 1
endif

" Plugin Functions }
