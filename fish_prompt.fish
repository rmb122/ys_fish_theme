set __fish_git_prompt_show_informative_status true
set __fish_git_prompt_showupstream true

set __fish_git_prompt_char_stateseparator ' '

set __fish_git_prompt_color_cleanstate green
set __fish_git_prompt_color_branch cyan
set __fish_git_prompt_color_stagedstate yellow

function fish_prompt --description 'Write out the prompt'
    set exit_status $status

    printf '\n%s# ' (set_color brblue)

    switch "$USER"
        case root
            printf '%s%s%s%s' (set_color black) (set_color --background yellow) (whoami) (set_color --background normal)
        case '*'
            printf '%s%s' (set_color cyan) (whoami)
    end

    printf ' %s@ %s%s %sin %s%s' (set_color grey)  (set_color green) (hostnamectl hostname|cut -d . -f 1) (set_color grey)  (set_color bryellow) (prompt_pwd)
    
    fish_git_prompt (printf ' %son %sgit:%%s' (set_color grey) (set_color brwhite))

    printf ' %s[%s]' (set_color grey) (date "+%H:%M:%S")
    if test $exit_status -gt 0
        printf " C:%s$exit_status" (set_color red)
    end

    printf '\n%s$ %s' (set_color brred) (set_color normal)
end

