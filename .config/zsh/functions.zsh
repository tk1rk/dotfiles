#!/usr/bin/env zsh

SAVEIFS=$IFS
IFS="$(pr  

zsh_update() {
  update_dotfiles
  if (( ${+functions[zcomet]} )); then
    zcomet self-update
    zcomet update
  fi
  exec zsh
}

screenres() {
    [ ! -z $1 ] && xrandr --current | grep '*' | awk '{print $1}' | line $1
}

screencast() {
    # Record screen 2 by default
    local screen=2
    local offset=""
    local heights=(`screenres 1 | awk -Fx '{print $2}'` `screenres 2 | awk -Fx '{print $2}'`)
    local bigger_height=$(echo $heights | sed "s/ /\n/" | sort -rg | line 1)

    if [ ! -z $2 ]; then
        screen=$2
    fi

    if [ ! -z $1 ]; then
        [ $screen -eq 1 ] && offset="+0,$(( $bigger_height -  $(screenres 1 | awk -Fx '{print $2}')))"
        # [ $screen -eq 2 ] && offset="+$(screenres 1 | awk -Fx '{print $1}')"
        ffmpeg -f x11grab -framerate 60 -s $(screenres $screen) -i :0.0$offset -f pulse -sample_rate 44100 -i default -c:v libx264 -preset ultrafast -c:a aac $1

       # Other codecs
       # -c:v ffvhuff   # lossless but HUGE
   else 
       echo "You need to precise an output file as first argument - eg 'example.mkv'"
    fi
}

oscreencast() {
    if [ ! -z $1 ]; then
        ffmpeg -f x11grab -s $(xdpyinfo | grep dimensions | awk '{print $2}') -i :0.0 $1
    else
        echo "You need to precise an output file as first argument - eg 'example.mkv'"
    fi
}

vidvolup() {
    output=output.mkv
    if [ ! -z $3 ]; then
        output=$3
    fi
    if [ ! -z $1 ] && [ ! -z $2 ]; then
        ffmpeg -i $1 -vol $(echo "256 + ((256 * $2) / 100)" | bc) -vcodec copy $output
    else 
        echo "You need to precise an output file as first argument and percentage of vol up as secong - eg 'example.mkv 100' to double the volume"
    fi
}

updatesys() {
    sh $DOTFILES/update.sh
}

extract() {
    for file in "$@"
    do
        if [ -f $file ]; then
            ex $file
        else
            echo "'$file' is not a valid file"
        fi
    done
}

mkextract() {
    for file in "$@"
    do
        if [ -f $file ]; then
            local filename=${file%\.*}
            mkdir -p $filename
            cp $file $filename
            cd $filename
            ex $file
            rm -f $file
            cd -
        else
            echo "'$1' is not a valid file"
        fi
    done
}

ex() {
    case $1 in
        *.tar.bz2)  tar xjf $1      ;;
        *.tar.gz)   tar xzf $1      ;;
        *.bz2)      bunzip2 $1      ;;
        *.gz)       gunzip $1       ;;
        *.tar)      tar xf $1       ;;
        *.tbz2)     tar xjf $1      ;;
        *.tgz)      tar xzf $1      ;;
        *.zip)      unzip $1        ;;
        *.7z)       7z x $1         ;; # require p7zip
        *.rar)      7z x $1         ;; # require p7zip
        *.iso)      7z x $1         ;; # require p7zip
        *.Z)        uncompress $1   ;;
        *)          echo "'$1' cannot be extracted" ;;
    esac
}

compress() {
    local DATE="$(date +%Y%m%d-%H%M%S)"
    tar cvzf "$DATE.tar.gz" "$@"
}

screenshot () {
    local DIR="$SCREENSHOT"
    local DATE="$(date +%Y%m%d-%H%M%S)"
    local NAME="${DIR}/screenshot-${DATE}.png"

    # Check if the dir to store the screenshots exists, else create it:
    if [ ! -d "${DIR}" ]; then mkdir -p "${DIR}"; fi

    # Screenshot a selected window
    if [ "$1" = "win" ]; then import -format png -quality 100 "${NAME}"; fi

    # Screenshot the entire screen
    if [ "$1" = "scr" ]; then import -format png -quality 100 -window root "${NAME}"; fi

    # Screenshot a selected area
    if [ "$1" = "area" ]; then import -format png -quality 100 "${NAME}"; fi

    if [[ $1 =~ "^[0-9].*x[0-9].*$" ]]; then import -format png -quality 100 -resize $1 "${NAME}"; fi

    if [[ $1 =~ "^[0-9]+$" ]]; then import -format png -quality 100 -resize $1 "${NAME}" ; fi

    if [[ $# = 0 ]]; then
        # Display a warning if no area defined
        echo "No screenshot area has been specified. Please choose between: win, scr, area. Screenshot not taken."
    fi
}

imgsize() {
    local width=$(identify -format "%w" "$1")> /dev/null
    local height=$(identify -format "%h" "$1")> /dev/null

    echo -e "Size of $1: $width*$height"
}

imgresize() {
    local filename=${1%\.*}
    local extension="${1##*.}"
    local separator="_"
    if [ ! -z $3 ]; then
        local finalName="$filename.$extension"
    else
        local finalName="$filename$separator$2.$extension"
    fi
    convert $1 -quality 100 -resize $2 $finalName
    echo "$finalName resized to $2"
}

imgresizeall() {
    for f in *.${1}; do
        if [ ! -z $3 ]; then
            imgresize "$f" ${2} t
        else
            imgresize "$f" ${2}
        fi
    done
}

imgoptimize() {
    local filename=${1%\.*}
    local extension="${1##*.}"
    local separator="_"
    local suffix="optimized"
    local finalName="$filename$separator$suffix.$extension"
    convert $1 -strip -interlace Plane -quality 85% $finalName
    echo "$finalName created"
}

Imgoptimize() {
    local filename=${1%\.*}
    local extension="${1##*.}"
    local separator="_"
    local suffix="optimized"
    local convert $1 -strip -interlace Plane -quality 85% $1
    echo "$1 created"
}

imgoptimizeall() {
    for f in *.${1}; do
        imgoptimize "$f"
    done
}

Imgoptimizeall() {
    for f in *.${1}; do
        Imgoptimize "$f"
    done
}

imgtojpg() {
    for file in "$@"
    do
        local filename=${file%\.*}
        convert -quality 100 $file "${filename}.jpg"
    done
}

imgtowebp() {
    for file in "$@"
    do
        local filename=${file%\.*}
        cwebp -q 100 $file -o $(basename ${filename}).webp
    done
}

gtrm() {
    git tag -d $1

    if [ ! -z "$2" ]; then
        git push $2 :refs/tags/$1
    else
        git push origin :refs/tags/$1
    fi
}

ssh-create() {
    if [ ! -z "$1" ]; then
        ssh-keygen -f $HOME/.ssh/$1 -t rsa -N '' -C "$1"
        chmod 700 $HOME/.ssh/$1*
    fi
}

dback () {
    if [ ! -z $1 ] && [ ! -z $2 ]; then
        if [ ! -z $3 ]; then
            BS=$3
        else
            BS="512k"
        fi

        dialog --defaultno --title "Are you sure?" --yesno "This will copy $1 to $2 (bitsize: $BS). Everything on $2 will be deleted.\n\n
        Are you sure?"  15 60 || exit

        (sudo pv -n $1 | sudo dd of=$2 bs=$BS conv=notrunc,noerror) 2>&1 | dialog --gauge "Backup from disk $1 to disk $2... please wait" 10 70 0
    else
        echo "You need to provide an input disk as first argument (i.e /dev/sda) and an output disk as second argument (i.e /dev/sdb)"
    fi
}

blimg() {
    if [ ! -z $1 ] && [ ! -z $2 ] && [ ! -z $3 ]; then
        local CYEAR=$(date +'%Y')
        local BASEDIR="${HOME}/workspace/webtechno/static"
        #Basedir current year
        local BASEDIRY="${HOME}/workspace/webtechno/static/${CYEAR}"

        if [ ! -d $BASEDIRY ]; then
            mkdir $BASEDIRY
        fi

        #basedir current article
        local BASEDIRC="${BASEDIRY}/${2}"

        if [ ! -d $BASEDIRP ]; then
            mkdir $BASEDIRP
        fi

        local IMGRESIZED=imgresize "${1} 780"
        echo "$IMGRESIZED"
    fi
}

postgdump() {
    local USER="postgres"
    local HOST="localhost"
    if [ ! -z $1 ]; then
        if [ -f "${1}.sql" ]; then
            rm -i "${1}.sql"
        fi

        if [ $# = 1 ]; then
            pg_dump -c -U $USER -h $HOST $1 | pv --progress > "${1}.sql"
            echo $1
        fi

        if [ $# = 2 ]; then
            pg_dump -c -U $2 -h $HOST $1 | pv --progress > "${1}.sql"
            echo $1
        fi

        if [ $# = 3 ]; then
            pg_dump -c -U $2 -h $3 $1 | pv --progress > "${1}.sql"
            echo $1
        fi
    fi

    if [ $# = 0 ]; then
        echo "You need at least to provide the database name"
    fi
}

postgimport() {
    local USER="postgres"
    local HOST="localhost"
    if [ ! -z $1 ]; then
        DB=${1%\.*}
        # sed -i "1s/^/CREATE DATABASE $DB;\n/" $1
        if [ $# = 1 ];
        then
            pv --progress ${1} | psql -U $USER -h $HOST $1 -d $DB
            echo $1
        fi

        if [ $# = 2 ]; then
            pv --progress ${1} | psql -U $1 -h $HOST $1 -d $DB
            echo $1
        fi

        if [ $# = 3 ]; then
            pv --progress ${1} | psql -U $1 -h $2 $1 -d $DB
            echo $1
        fi
    fi

    if [ $# = 0 ]; then
        echo "You need at least to provide the database name"
    fi
}

matrix () {
    local lines=$(tput lines)
    cols=$(tput cols)

    awkscript='
    {
        letters="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%^&*()"
        lines=$1
        random_col=$3
        c=$4
        letter=substr(letters,c,1)
        cols[random_col]=0;
        for (col in cols) {
            line=cols[col];
            cols[col]=cols[col]+1;
            printf "\033[%s;%sH\033[2;32m%s", line, col, letter;
            printf "\033[%s;%sH\033[1;37m%s\033[0;0H", cols[col], col, letter;
            if (cols[col] >= lines) {
                cols[col]=0;
            }
    }
}
'

echo -e "\e[1;40m"
clear

while :; do
    echo $lines $cols $(( $RANDOM % $cols)) $(( $RANDOM % 72 ))
    sleep 0.05
done | awk "$awkscript"
}

pgdump() {
    pg_dump -U postgres -h localhost x_loc_0bdf08de > pulsecheck_service_test.sql 
}

mkcd() {
    local dir="$*";
    local mkdir -p "$dir" && cd "$dir";
}

mkcp() {
    local dir="$2"
    local tmp="$2"; tmp="${tmp: -1}"
    [ "$tmp" != "/" ] && dir="$(dirname "$2")"
    [ -d "$dir" ] ||
        mkdir -p "$dir" &&
        cp -r "$@"
}

mkmv() {
    local dir="$2"
    local tmp="$2"; tmp="${tmp: -1}"
    [ "$tmp" != "/" ] && dir="$(dirname "$2")"
    [ -d "$dir" ] ||
        mkdir -p "$dir" &&
        mv "$@"
}
