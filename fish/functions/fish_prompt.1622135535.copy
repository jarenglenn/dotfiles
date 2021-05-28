function fish_prompt
    set -l status_copy $status
    set -l pwd_info (pwd_info "/")
    set -l dir
    set -l base

    set -l dark_mode 1 #default to dark mode
    set -l base_color
    set -l text_color
    set -l split_color

    if functions -q is_dark_mode
        is_dark_mode; or set -e dark_mode
    end
    if set -lq dark_mode
        set base_color BBB 050505
        set text_color FFF
        # set split_color 000
    else
        set base_color 555 DDD
        set text_color 000
        # set split_color FFF
    end
    set split_color $base_color[2]

    if test "$PWD" = ~
        set base "~"

    else if pwd_is_home
        set dir "~/"
    else
        if test "$PWD" != /
            set dir "/"
        end

        set base (set_color red)"/"
    end

    if test ! -z "$pwd_info[1]"
        set base "$pwd_info[1]"
    end

    if test ! -z "$pwd_info[2]"
        set dir "$dir$pwd_info[2]/"
    end

    if test ! -z "$pwd_info[3]"
        segment $base_color " $pwd_info[3] "
    end

    if set branch_name (git_branch_name)
        set -l git_color black green
        set -l git_glyph ""

        if git_is_staged
            set git_color black yellow

            if git_is_dirty
                set git_color $git_color white red
            end

        else if git_is_dirty
            set git_color white red

        else if git_is_touched
            set git_color white red
        end

        if git_is_detached_head
            set git_glyph "➤"

        else if git_is_stashed
            set git_glyph "╍╍"
        end

        set -l prompt
        set -l git_ahead (git_ahead "+ " "- " "+- ")

        if test "$branch_name" = master
            set prompt " $git_glyph $git_ahead"
        else
            set prompt " $git_glyph $branch_name $git_ahead"
        end

        if set -q git_color[3]
            segment "$git_color[3]" "$git_color[4]" "$prompt"
            segment $split_color $split_color
            segment "$git_color[1]" "$git_color[2]" " $git_glyph "
        else
            segment "$git_color[1]" "$git_color[2]" "$prompt"
        end
    end

    segment $base_color " $dir"(set_color $text_color)"$base "

    if test ! -z "$SSH_CLIENT"
        set -l color bbb 222

        if test 0 -eq (id -u "$USER")
            set color red 222
        end

        segment $color (host_info " usr@host ")

    else if test 0 -eq (id -u "$USER")
        segment red 222 " \$ "
    end

    if test "$status_copy" -ne 0
        segment red white (set_color -o)" ! "(set_color normal)

    else if last_job_id > /dev/null
        segment white 333 " %% "
    end

    if [ "$theme_display_virtualenv" != 'no' ]; and set -q VIRTUAL_ENV
        segment yellow blue " "(basename "$VIRTUAL_ENV")" "
    end

    if [ "$theme_display_ruby" != 'no' ]; and set -q RUBY_VERSION
        segment red fff " "(basename "$RUBY_VERSION")" "
    end

    if test "$fish_key_bindings" = "fish_vi_key_bindings"
      switch $fish_bind_mode
        case default
          segment white red "[N]"
        case insert
          segment black green "[I]"
        case replace-one
          segment yellow blue "[R]"
        case visual
          segment white magenta "[V]"
      end
    end

    segment_close
end
