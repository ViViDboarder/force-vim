
if !exists("g:force_dispatch_background")
    let g:force_dispatch_background = 0
end

function! ForceDeploy()
    let filePath = expand("%")

    let command = "force push \"" . filePath . "\""
    call ForceTryStart(command)

endfunction

function! ForceDeployTest()
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

function! ForceTarget(...)
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
command! -nargs=0 ForceDeployTest call ForceDeployTest() " Deploy current file and run test
"command! -nargs=0 ForceRetrieve call ForceRetrieve()     " Retrieve current file
command! -nargs=? ForceTarget call ForceTarget(<f-args>) " Change deploy target

" Set SF Compiler
autocmd BufNewFile,BufRead *.cls,*.trigger,*.page,*.component compiler ForceCli

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
