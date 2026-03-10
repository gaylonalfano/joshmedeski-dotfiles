function kp --description "Kill processes"
    set -l __kp__pid (ps -ef | sed 1d | fzf $FZF_DEFAULT_OPTS -m --header='[kill:process]' | awk '{print $2}')
    if test -n "$__kp__pid"
        if test -n "$argv[1]"
            echo $__kp__pid | xargs kill $argv[1]
        else
            echo $__kp__pid | xargs kill -9
        end
        kp
    end
end
