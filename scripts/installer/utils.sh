function secho {
    echo "SEARTIPY: $1"
}

function spull {
    if [ -e $1 ]; then
        cd $1
        if git status --porcelain > /dev/null; then
            git pull origin master
        fi
    fi
}

function sclone {
    local source=$1
    local target=$2
    local recursive=$3
    if [ -e $target ]; then
        secho "pulling $1 ..."
        cd $target
        git pull --all > /dev/null
    else
        secho "cloning $1 ..."
        git clone $source $target $recursive
    fi
}

function force-clone {
    local source=$1
    local target=$2
    [ -e $target ] && trash-put $target
    git clone $source $target
}

function smkdir {
    local target=$1
    if [ -e $target ]; then
        secho "bin already exists, skipping"
    else
        mkdir -p $target 2> /dev/null
    fi
}

function safe-append {
    local source=$1
    local target=$2
    local search_for=$3
    if grep $source $target > /dev/null; then
        secho "$source already exists in $target, skipping..."
    elif grep $3 $target > /dev/null; then
        secho "$source already exists in $target, skipping..."
    else
        secho "adding $source to .bashrc..."
        echo $source >> $target
    fi
}

function sln {
    local source=$1
    local target=$2
    if [ -L $target ]; then
            trash-put $target
            ln -s $source $target
    elif [ -e $target ]; then
        secho "$target exists and not a link, skipping"
    else
        ln -s $source $target
    fi
}

function smv {
    local $source=$1
    [ -e $1 ] && mv -b $1 $2 > /dev/null
}
