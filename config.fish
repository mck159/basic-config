alias pbcopy="head -c -1 | xclip -selection clipboard"


function is_git_repository --description 'Check if the current directory is a git repository'
  git rev-parse --is-inside-work-tree ^/dev/null >/dev/null
end
# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
#set __fish_git_prompt_showuntrackedfiles 'yes' 
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

# Status Chars
set __fish_git_prompt_char_dirtystate '*'
set __fish_git_prompt_char_stagedstate 's'
set __fish_git_prompt_char_untrackedfiles 'u'
set __fish_git_prompt_char_stashstate '^'
set __fish_git_prompt_char_upstream_ahead '+'
set __fish_git_prompt_char_upstream_behind '-'
function fish_prompt
  set last_status $status

  set_color $fish_color_cwd
  printf '%s' (prompt_pwd)
  set_color normal

  printf '%s ' (__fish_git_prompt)

  if is_git_repository; and not git branch --merged | grep -q master
    set current_branch (git rev-parse --abbrev-ref HEAD)
    set current_branch_based_on_develop (git branch --merged | grep master)
    set_color red
    printf '(!!master) '
  end

  set_color normal
end
