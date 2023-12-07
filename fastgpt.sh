#!/bin/bash
ncol="\033[0m"
bold="\033[1m"
dim="\033[2m"
uline="\033[4m"
reverse="\033[7m"
red="\033[31m"
green="\033[32m"
yellow="\033[33m"
blue="\033[34m"
purple="\033[35m"
cyan="\033[36m"
white="\033[37m"

logf=$(realpath `dirname "$0"`)/install.log

label(){ #labelName
  printf $reverse$bold$cyan"$1$ncol\n"
}

Head(){
  printf $bold$uline"$1$ncol\n"
}

addLog(){ # symbol color text
  printf $dim$2$1$ncol$bold$2"$3$ncol"
}

addPad(){ # text
  printf "  $1" | sed -z 's/\n/\n  /g'
  printf "\n"
}

desc(){
  addPad "$1"
}

scs(){ # message
 addLog "["$ncol$bold$green"+$ncol$green$dim]" $green " $1"
}


blt(){ # message
  addLog "["$ncol$bold$purple"*$ncol$purple$dim]" $purple " $ncol$white$1"
}

err(){ # message
  addLog "["$ncol$red$bold"-$ncol$dim$red]" $red " $1\n"
}

wrn(){ # message
  addLog "["$ncol$yellow$bold"!$ncol$dim$yellow]" $yellow " $1\n"
}

ask(){ #text #show #force #default
  if [ "$1" != "" ]
  then
  addLog "["$ncol$bold$blue"?$ncol$dim$blue]" $blue " $1"

  fi
  read -p "" inp

  while [ "$inp" = "" ]
  do
    if [ "$4" != "" ]
    then
      inp=$4
      break
    fi
    if [ "$3" = "True" ]
    then
      addLog "["$ncol$bold$blue"?$ncol$dim$blue]" $blue " $1"
      read -p "" inp
    fi
  done
  if [ "$2" = "True" ]
  then
    printf "  $bold$cyan""==> $ncol$inp\n"
  fi
}
inp(){
  printf "$bold$blue$1$ncol"
  ask ""
}
### end painter.sh

check(){
  if [ "$?" != "0" ]; then
    echo -e "\e[1;31m FAILED \e[0m"
    echo -e "\e[1;31mERROR:\e[0m $1"
    exit
  fi
}

check_out(){
  if [ "$?" == "0" ]; then
    echo -e "\e[1;32m DONE \e[0m"
  else
    echo -e "\e[1;31m ERROR \e[0m"
    exit
  fi
}

job (){
    $@ >> $logf 2>&1 
}

show_banner(){
  clear
  printf "\n\t"
  label "      FASTGPT SETUP     "

  printf "\t"
  printf "install with one command\n\n"
  printf "\t    $bold$blue""Author: "$ncol"s0ubhik\n\n"
}

show_banner
sudo true
rm -rf $logf

blt "Preinstall stuff ..."
    job sudo apt-get update
    check_out

which git > /dev/null
if [ "$?" != "0" ]; then
    blt "Installing Git ..."
        job sudo apt-get install -y git
        check_out
fi

which node > /dev/null
if [ "$?" != "0" ] || [ $(node -v | cut -d '.' -f1) != "v18" ]; then
    blt "Installing NodeJS 18.x ..."
        job sudo apt-get install -y ca-certificates curl gnupg
        job sudo mkdir -p /etc/apt/keyrings
        check "Basic Prerequisite"

        curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/nodesource.gpg
        check "Downloading and importing the Nodesource GPG key"

        NODE_MAJOR=18
        echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" |  sudo tee /etc/apt/sources.list.d/nodesource.list > /dev/null
        check "Creating deb repository"

        job sudo apt-get update
        job sudo apt-get install nodejs -y
        check_out
fi

which pnpm > /dev/null
if [ "$?" != "0" ]; then
    blt "Installing pnpm ..."
    curl -fsSL https://get.pnpm.io/install.sh | sh - >> $logf 2>&1 
    check_out
    source ~/.bashrc  
fi

if [ ! -d FastGPT ]; then
  blt "Cloning FastGPT ..."
    job git clone https://github.com/s0ubhik/FastGPT.git
    check_out
fi

blt "Installing Packages ..."
  cd FastGPT
  pnpm i >> $logf 2>&1 
  check_out
