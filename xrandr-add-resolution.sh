#!/bin/bash

openXprofile(){
	nano $HOME/.xprofile
	exit 
}

help(){
	echo " ./AddXrandrVGA <width> <height> to add a new resolution"
	echo " ./AddXrandrVGA -v to edit .xprofile "
	exit
}

save(){
	read -p "Save? [Y/N]: " apply 
	if [ "$apply" == "y" ]; then
		if [ -f $HOME/.xprofile ]; then 
			echo xrandr --newmode $newValue >> $HOME/.xprofile
			echo xrandr --addmode $VGA_NAME $novoModo >> $HOME/.xprofile
			#echo xrandr --output VGA1 --mode $novoModo >> $HOME/.xprofile
			echo -e " \n" >> $HOME/.xprofile
			echo -e "\033[01;32mSaving on .xprofile ...\033[01;37m"
		else 
			touch $HOME/.xprofile
			chmod +x $HOME/.xprofile
			echo '#!/bin/bash' > $HOME/.xprofile
			echo xrandr --newmode $newValue >> $HOME/.xprofile
			echo xrandr --addmode $VGA_NAME $novoModo >> $HOME/.xprofile
			echo -e " \n" >> $HOME/.xprofile
			echo -e "\033[01;32mSaving on .xprofile ...\033[01;37m"
		fi
	else
		echo -e "\033[01;31m[Exiting without saving]\033[01;37m \n"
	fi
}

if [ "$1" == "-v" ]; then
	openXprofile
fi

if [ -z "$1" ] && [ -z "$2" ]; then
	echo "Error! Paraments needed, try ' ./xrandr-add-resolution --help' for help "
	exit
fi

if [ "$1" == "--help" ]; then
	help
fi

VGA_NAME+=$(xrandr | grep "VGA" | awk '{print $1}')
CVT_VALUE=$(cvt $1 $2 | tee /dev/tty ) 
novoModo=""
novoModo+='"'
novoModo+=$(echo $CVT_VALUE | cut -d '"' -f2 | tee /dev/tty) 
novoModo+='"'
newValue='"'
newValue+=$( echo $CVT_VALUE | cut -d '"' -f 2- | tee /dev/tty ) 

if xrandr --newmode $newValue && xrandr --addmode $VGA_NAME $novoModo; then
	echo -e "\033[01;32m[OK]\033[01;37m"
	save
else 
	echo -e "\033[01;31m[ERROR]\033[01;37m"
fi