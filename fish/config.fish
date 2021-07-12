set PATH \
    /home/jaren/.local/bin \
    /home/jaren/.gem/ruby/3.0.0/bin \
    /home/jaren/.poetry/binm/ \
    $PATH
     
# Removes fish greeting 
set fish_greeting

# Disable venv for powerline replacement
set VIRTUAL_ENV_DISABLE_PROMPT disable

source /opt/asdf-vm/asdf.fish


function la
    exa -la --icons $argv
end


function udb
    sudo updatedb
end

function be 
    # set toExec ruby $argv -p 5000
    bundle exec $argv
end

function activate
    source ./.venv/bin/activate.fish
end

function ccd --wraps "git clone"
    git clone $argv[1] && cd (basename $argv[1] .git)
end

direnv hook fish | source

starship init fish | source
