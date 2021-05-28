function fish_right_prompt
    set -l status_copy $status
    set -l status_code $status_copy

    set -l dark_mode 1 #default to dark mode
    if functions -q is_dark_mode
        is_dark_mode; or set -e dark_mode
    end

    set -l status_color 555; set -lq dark_mode; or set status_color DDD
    set -l clock_color $status_color

    set -l status_glyph " "
    set -l duration_glyph

    switch "$status_copy"
        case 0 "$__metro_status_last"
            set status_code
    end

    set -g __metro_status_last $status_copy

    if test "$status_copy" -eq 0
        set duration_glyph " "
    else
        set status_color red
        set status_glyph │
    end

    if test "$CMD_DURATION" -gt 250
        if test ! -z "$status_code"
            echo -sn (set_color $status_color) "($status_code)" (set_color normal)
            set status_glyph ┃
        end

        set -l duration (echo $CMD_DURATION | humanize_duration)
        echo -sn (set_color $status_color) " ($duration) $duration_glyph" (set_color normal)

    else
        if test ! -z "$status_code"
            echo -sn (set_color $status_color) "($status_code) " (set_color normal)
            set status_glyph ┃
        end
    end
    set -q fish_right_prompt_show_clock; and echo -sn (set_color $clock_color) (date "+%H:%M:%S")
    echo -sn (set_color $status_color) "$status_glyph" (set_color normal)
end
