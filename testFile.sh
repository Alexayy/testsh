function InstEssent()
{
    dnf -y install htop
    sleep 1
}

printf "%s" "${installOf}"

InstEssent  &
pid_InstEssent="$!"

while kill -0 "$pid" 2> /dev/null
do
    printProgressBar 
    sleep 1
done
