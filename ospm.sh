#!/bin/bash

# success = green
# warning or err = red
# help or neutral things = cyan
NC='\033[0m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'

slash="/"
deps="dependencies"

#map functions so we can support bash 3
hinit() {
    rm -f /tmp/hashmap.$1
}

hput() {
    echo "$2 $3" >> /tmp/hashmap.$1
}

hget() {
    grep "^$2 " /tmp/hashmap.$1 | awk '{ print $2 };'
}


function library {
	if [[ "$1" == "save" ]]; then
		printf "$2\n" > /usr/local/lib/ospmLibSettings
	elif [[ "$1" == "clean" ]]; then
		cat /usr/local/lib/ospmLibSettings
	else
		output=$(cat /usr/local/lib/ospmLibSettings)
		printf "${GREEN}$output\n${NC}"
	fi

}

function help {
        printf "${GREEN}Key: <variable> ${NC}"
        printf "${GREEN}Usage: ospm [version] [help] [library <> <>] ... \n${NC}"
        printf "${GREEN}version                                            Show version\n${NC}"
        printf "${GREEN}help                                               Show command line options\n${NC}"
        printf "${GREEN}library save <path>                                Save library path\n${NC}"
        printf "${GREEN}library show                                       Show library path\n${NC}"
        printf "${GREEN}install <author> <package name> <version>          Install package(s)\n${NC}"
        printf "${GREEN}install list <path>                                Install package(s)\n${NC}"
        printf "${GREEN}uninstall <author> <package name> <version>        Uninstall package(s)\n${NC}"
        printf "${GREEN}uninstall <author> <package name> <version> force  Uninstall package(s)\n${NC}"
        printf "${GREEN}parse install <input>                              Install package(s) in a file\n${NC}"
        printf "${GREEN}parse save <input> <output>                        Save used packages in a file to a list\n${NC}"
        printf "${GREEN}clean                                              Remove unrequired package(s)\n${NC}"
        printf "${GREEN}For more information go to: skp2140.github.io/openSCADpm/\n${NC}"
}

function help_more {
	# check if there is a second argu
	# if yes, match cases
	# if no, call help

	if [ -z "$1" ]; then
		case "$1" in
		"library" )
					printf "${YELLOW}library <save> <path>         Save library path\n${NC}"
	        printf "${YELLOW}library <show>                Show library path\n${NC}"
					;;
		"install" )
					printf "${YELLOW}install <author> <package name> <version>       Install package(s)\n${NC}"
					;;
	    "uninstall" )
					printf "${YELLOW}uninstall <author> <package name> <version>     Uninstall package(s)\n${NC}"
					;;
		*)
	        	printf "${RED}command not found\n${NC}";
		esac
	else
		help
	fi
}


function clean {
  libLoc=$(cat /usr/local/lib/ospmLibSettings)
  requiredBy="requiredBy"
  if [ $libLoc != "/" ]; then
    for di in $( ls -d $libLoc$slash*/ ) ; do
      IFS='-' read -ra dirPackage <<< "$di"
      if [ ${#dirPackage[@]} == 3 ]; then
        frb="$echo($di$requiredBy)"
        if [[ ! -f $frb ]]; then
          echo -n "Uninstall $di (y/n)? "
    				read answer
            if echo "$answer" | grep -iq "^y" ; then
                removeRequiredBy "${dirPackage[0]} ${dirPackage[1]} ${dirPackage[2]}"
                # echo "would delete! $di"
                rm -rf "$di"
    				else
    				    echo "Ok, won't uninstall then."
    				fi
          fi
      fi

    done
  fi
}

function removeRequiredBy {
  requiredBy="requiredBy"
  requiredByFile="$libLoc$slash$1-$2-$3$slash$requiredBy"
  libLoc=$(cat /usr/local/lib/ospmLibSettings)
  for d in $( ls -d $libLoc$slash*/ ) ; do
      thisPackage="$1 $2 $3"
      frb="$echo($d$requiredBy)"
      # echo $thisPackage
      if [[ -f $frb ]]; then
        grep -vwE $thisPackage $d$requiredBy > $d$requiredBy
        #check if requiredby is empty
        fileOut=$(cat $frb)
        if [[ -z "${fileOut// }" ]]; then
          rm $frb
        fi
      fi
  done
}

function uninstall {
	libLoc=$(cat /usr/local/lib/ospmLibSettings)
	packageDir="$1-$2-$3"
	#some safety
	if [ ! -z $libLoc ] && [ "$libLoc" != "/" ] && [ ! -z $1 ] && [ ! -z $2 ] && [ ! -z $3 ]; then
		#for each package check if the target package is a requirement
		#if so it is an easy stop (show all for ease) with little processing

		beingUsed=false
		if [[ $4 != "force" ]]; then
			for d in $( ls -d $libLoc$slash*/ ) ; do
        ddeps=$d$deps
        if [[ -f $ddeps ]]; then
          if grep -Fxq "$1 $2 $3" $d$deps
  				then
  					echo "$1 $2 $3 is being used in $d"
  					beingUsed=true
  				fi
        fi
			done

		fi

		if [[ $beingUsed = true ]]; then
			echo -n "Proceed with uninstall (y/n)? "
				read answer
				if echo "$answer" | grep -iq "^y" ; then
            removeRequiredBy $1 $2 $3
				    rm -rf $libLoc$slash$packageDir
				else
				    echo "Ok, will not uninstall then."
				fi
    else
      removeRequiredBy $1 $2 $3
      rm -rf $libLoc$slash$packageDir
    fi

	fi
}



function parse {
  regex="\s*include <([A-Za-z0-9_]+)-([A-Za-z0-9_]+)-([A-Za-z0-9_\.]+)"
  while read -r line; do
    if [[ $line =~ $regex ]]; then
      echo $line
      a=${BASH_REMATCH[1]}
      b=${BASH_REMATCH[2]}
      c=${BASH_REMATCH[3]}
      echo $a $b $c
      if [ $1 == "install" ]; then
          source ospm.sh install $a $b $c
      fi
      if [ $1 == "save" ]; then
        if ! grep -Fxq "$a $b $c" $3 ; then
         echo "$a $b $c" >> $3
        fi
      fi
    fi
  done < $2

}

function install {
	libLoc=$(cat /usr/local/lib/ospmLibSettings)
	#install from list
	if [[ ! -z $libLoc ]]; then
		if [[ "$1" == "list" ]]; then
			if [ -f "$2" ]; then
				while read -r dep; do
					printf "${GREEN}Installing dependency: $dep\n${NC}"
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
			if [ ! -d "$saveLoc" ]; then
				git clone -b $3  --single-branch --depth 1 https://github.com/$1/$2 $saveLoc
				# git clone https://github.com/$1/$2.git $saveLoc
			else
				printf "${GREEN}$1-$2-$3 already installed\n${NC}"
			fi

				#required by file
				requiredBy="requiredBy"
				requiredByFile=$libLoc$slash$1-$2-$3$slash$requiredBy
				if [ ! -z "$4" ] && [ ! -z "$5" ] && [ ! -z "$6" ] && ( ! grep -Fxq "$4 $5 $6" $requiredByFile ); then
           echo "$4 $5 $6" >> $requiredByFile
        else
          touch $requiredByFile
        fi

				if [ -f "$saveLoc$slash$deps" ]; then
					while read -r dep; do
						dep_dir=$libLoc$slash$dep
						if [ ! -z "$dep" ] && [ "$dep" != "\n" ]; then

              depArr=($dep)
              a="${dep[0]}"
              b="${dep[1]}"
              c="${dep[2]}"
							source ospm.sh install "$dep $1 $2 $3"
						fi
					done <$saveLoc$slash$deps
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
	"uninstall" )
				uninstall $2 $3 $4 $5
				;;
    "version" )
                printf "${YELLOW}ospm 0.0.1\n${NC}"
                ;;
    "parse" )
        parse $2 $3 $4
        ;;
    "clean" )
      clean
      ;;
    "help" )
                help
                ;;

	"install") $2 $3 $4 $5 $6 $7
	;;

	*)
	printf "${RED}command not found\n${NC}";
esac
