set PATH /home/jaren/.local/bin /home/jaren/.gem/ruby/3.0.0/bin $PATH

# Removes fish greeting 
set fish_greeting

# Disable venv for powerline replacement
set VIRTUAL_ENV_DISABLE_PROMPT disable



function la
    exa -la --icons $argv
end


function udb
    sudo updatedb
end

function be
    set toExec ruby $argv -p 5000
    bundle exec $toExec
end
