# success = green
# warning or err = red
# help or neutral things = cyan
NC='\033[0m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'


function library {
	if [[ "$1" == "save" ]]; then
		printf "$2\n" > /usr/local/lib/ospmLibSettings
	elif [[ "$1" == "clean" ]]; then
		cat /usr/local/lib/ospmLibSettings
	else
		printf "${YELLOW}Module library is:\n${NC}"
			output=$(cat /usr/local/lib/ospmLibSettings)
		printf "${YELLOW}$output\n${NC}"
  fi

}

function help {
        printf "${YELLOW}Usage: ospm [-v] [-h] [library <> <>]\n${NC}"
        printf "${YELLOW}-v                Show version\n${NC}"
        printf "${YELLOW}-h                Show command line options\n${NC}"
        printf "${YELLOW}library $2 $3         Save XXX in library\n${NC}"
}

function install {
	libLoc=$(cat /usr/local/lib/ospmLibSettings)
	if [[ ! -z $libLoc ]]; then
		if [[ "$1" == "list" ]]; then
			echo "list"
			echo $2
			if [ -f "$2" ]; then
				while read -r dep; do
					printf "${YELLOW}$dep\n${NC}"
					dep_dir=$libLoc$slash$dep
					if [ ! -z "$dep" ] && [ "$dep" != "\n" ]; then
							source ospm.sh install $dep
					fi
				done <$2
			fi
		else
			slash=$(echo /)
			deps=$(echo dependencies)
			underscore_ospm=$(echo "_ospm")
			saveLoc=$libLoc$slash$1-$2-$3
			echo $saveLoc
			if [ ! -d "$saveLoc" ]; then
				git clone -b $3  --single-branch --depth 1 https://github.com/$1/$2 $saveLoc
				# git clone https://github.com/$1/$2.git $saveLoc

				if [ -f "$saveLoc$slash$deps" ]; then
					while read -r dep; do
						printf "${YELLOW}$dep\n${NC}"
						dep_dir=$libLoc$slash$dep
						if [ ! -z "$dep" ] && [ "$dep" != "\n" ]; then
								source ospm.sh install $dep
						fi
					done <$saveLoc$slash$deps
				fi

			else
				printf "${GREEN}$1-$2-$3 already installed$\n${NC}"
			fi
		fi


	else
		printf "${YELLOW}Save the location of your installation library with: \n${NC}"
		printf "${YELLOW}ospm library <location>\n${NC}"
		printf "${YELLOW}ospm help has more information\n${NC}"
	fi
}

case "$1" in
	"library" )
     		library $2 $3
		;;
		"install" )
			install $2 $3 $4
		;;
    "-v" )
                printf "${YELLOW}ospm 0.0.1\n${NC}"
                ;;

    "-h" )
                help
                ;;
	*)
        	printf "${RED}command not found\n${NC}";
esac
