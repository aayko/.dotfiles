function is_dirty {
    [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && echo "*"
}

bash_green="\033[32m"
bash_color_reset="\033[0m"

function set_prompt {
    local branch_name=$(git symbolic-ref --short HEAD 2>/dev/null)
    local dirty_status="$(is_dirty)"

    local git_info=""
    if [ -n "$branch_name" ]; then
        git_info=" $branch_name$dirty_status"
    fi

    local prompt_final_symbol=" >"
    if [ "$USER" = root ]; then
        prompt_final_symbol=" #"
    elif [ -n "$VIMRUNTIME" ]; then
        prompt_final_symbol=" %%"
    elif [ -n "$IN_NIX_SHELL" ]; then
        prompt_final_symbol=" !"
    elif [ $0 = bash ]; then
        prompt_final_symbol=" $"
    fi

    if [ $0 = bash ]; then
        PS1="\w$bash_green$git_info$bash_color_reset$prompt_final_symbol "
    else 
        PS1="%~%F{green}$git_info%f$prompt_final_symbol "
    fi
}
