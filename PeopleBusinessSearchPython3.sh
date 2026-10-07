#!/bin/bash

# Runs the Melissa People Business Search Cloud API Python 3 sample.
#
# This script runs PeopleBusinessSearchPython3.py with python3, passing along the
# license and (if supplied) the search fields.
#
# Overall flow:
#   1. Parse the command-line options below.
#   2. Resolve the license (--license, then a prompt, then the MD_LICENSE environment variable).
#   3. Run PeopleBusinessSearchPython3.py: with the search fields if any was supplied,
#      otherwise with only the license (the Python program prompts for each field).
#
# Options (each takes a value):
#   --maxrecords           Maximum number of records to return.
#   --matchlevel           Match level to search with.
#   --addressline1         Street address to search.
#   --locality             Locality (city) to search.
#   --administrativearea   Administrative area (state) to search.
#   --postal               Postal code to search.
#   --anyname              Person or business name to search.
#   --license              License string. If omitted, the script prompts for it; if the prompt
#                          is left blank, it falls back to MD_LICENSE. Running without --license
#                          always prompts, even when MD_LICENSE is set.
#
# Examples:
#   ./PeopleBusinessSearchPython3.sh --license "your-license"
#   ./PeopleBusinessSearchPython3.sh --maxrecords "10" --matchlevel "10" --addressline1 "22382 Avenida Empresa" --locality "Rancho Santa Margarita" --administrativearea "CA" --postal "92688" --anyname "Melissa Data" --license "your-license"

######################### Constants ##########################

RED='\033[0;31m' #RED
NC='\033[0m' # No Color

######################### Parameters ##########################

maxrecords=""
matchlevel=""
addressline1=""
locality=""
administrativearea=""
postal=""
anyname=""
license=""

# Read each --flag and its value. A flag with no value, or whose value starts with "-",
# is an error. Unrecognized options are ignored.
while [ $# -gt 0 ] ; do
  case $1 in
    --maxrecords) 
        if [ -z "$2" ] || [[ $2 == -* ]];
        then
            printf "${RED}Error: Missing an argument for parameter \'max records\'.${NC}\n"  
            exit 1
        fi 

        maxrecords="$2"
        shift
        ;;
    --matchlevel) 
        if [ -z "$2" ] || [[ $2 == -* ]];
        then
            printf "${RED}Error: Missing an argument for parameter \'match level\'.${NC}\n"  
            exit 1
        fi 

        matchlevel="$2"
        shift
        ;;
    --addressline1) 
        if [ -z "$2" ] || [[ $2 == -* ]];
        then
            printf "${RED}Error: Missing an argument for parameter \'addressline1\'.${NC}\n"  
            exit 1
        fi 

        addressline1="$2"
        shift
        ;;
    --locality)  
        if [ -z "$2" ] || [[ $2 == -* ]];
        then
            printf "${RED}Error: Missing an argument for parameter \'locality\'.${NC}\n"  
            exit 1
        fi 

        locality="$2"
        shift
        ;;
    --administrativearea) 
        if [ -z "$2" ] || [[ $2 == -* ]];
        then
            printf "${RED}Error: Missing an argument for parameter \'administrative area\'.${NC}\n"  
            exit 1
        fi 

        administrativearea="$2"
        shift
        ;;
    --postal)         
        if [ -z "$2" ] || [[ $2 == -* ]];
        then
            printf "${RED}Error: Missing an argument for parameter \'postal\'.${NC}\n"  
            exit 1
        fi 
        
        postal="$2"
        shift
        ;;
    --anyname) 
        if [ -z "$2" ] || [[ $2 == -* ]];
        then
            printf "${RED}Error: Missing an argument for parameter \'any name\'.${NC}\n"  
            exit 1
        fi 

        anyname="$2"
        shift
        ;;
    --license) 
        if [ -z "$2" ] || [[ $2 == -* ]];
        then
            printf "${RED}Error: Missing an argument for parameter \'license\'.${NC}\n"  
            exit 1
        fi 

        license="$2"
        shift 
        ;;
  esac
  shift
done

########################## Main ############################
printf "\n===================== Melissa People Business Search Cloud API ========================\n"

# Get license (either from parameters or user input)
if [ -z "$license" ];
then
  printf "Please enter your license string: "
  read license
fi

# Check for License from Environment Variables 
if [ -z "$license" ];
then
  license=`echo $MD_LICENSE` 
fi

if [ -z "$license" ];
then
  printf "\nLicense String is invalid!\n"
  exit 1
fi

# Run project
# No search fields supplied -> run with only the license (the program prompts for each field);
# otherwise pass them all through. Unsupplied fields arrive as empty strings, and the
# program prompts for them.
if [ -z "$maxrecords" ] && [ -z "$matchlevel" ] && [ -z "$addressline1" ] && [ -z "$locality" ] && [ -z "$administrativearea" ] && [ -z "$postal" ] && [ -z "$anyname" ];
then
    python3 PeopleBusinessSearchPython3.py --license "$license"
else
    python3 PeopleBusinessSearchPython3.py \
      --license "$license" \
      --maxrecords "$maxrecords" \
      --matchlevel "$matchlevel" \
      --addressline1 "$addressline1" \
      --locality "$locality" \
      --administrativearea "$administrativearea" \
      --postal "$postal" \
      --anyname "$anyname"
fi

