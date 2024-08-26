set -g __fish_git_prompt_show_informative_status true
set -g __fish_git_prompt_showupstream true

set -g __fish_git_prompt_char_stateseparator ' '

set -g __fish_git_prompt_showcolorhints true
set -g __fish_git_prompt_color_branch cyan
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_color_cleanstate green

if type -q hostname
    set -g __hostname_command 'hostname | cut -d . -f 1'
else
    set -g __hostname_command 'hostnamectl hostname | cut -d . -f 1'
end

function fish_prompt --description 'Write out the prompt'
    set exit_status $status

    printf '\n%s# ' (set_color brblue)

    switch "$USER"
        case root
            printf '%s%s%s%s' (set_color black) (set_color --background yellow) (whoami) (set_color --background normal)
        case '*'
            printf '%s%s' (set_color cyan) (whoami)
    end

    printf ' %s@ %s%s %sin %s%s' (set_color grey)  (set_color green) (eval $__hostname_command) (set_color grey)  (set_color bryellow) (prompt_pwd)
    
    fish_git_prompt (printf ' %son %sgit:%%s' (set_color grey) (set_color brwhite))

    printf ' %s[%s]' (set_color grey) (date "+%H:%M:%S")

    if test $SHLVL -gt 2
        printf " L:%s%d%s" (set_color cyan) (math $SHLVL - 1) (set_color normal)
    end

    if test $exit_status -gt 0
        printf " C:%s$exit_status" (set_color red)
    end

    printf '\n%s$ %s' (set_color brred) (set_color normal)
end
