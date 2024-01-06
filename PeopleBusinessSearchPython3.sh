#!/bin/bash

# Name:    PeopleBusinessSearchCloudAPI
# Purpose: Execute the PeopleBusinessSearchCloudAPI program

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
if [ -z "$maxrecords" ] && [ -z "$matchlevel" ] && [ -z "$addressline1" ] && [ -z "$locality" ] && [ -z "$administrativearea" ] && [ -z "$postal" ] && [ -z "$anyname" ];
then
    python3 PeopleBusinessSearchPython3.py --license $license  
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

