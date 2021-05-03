#!/bin/bash
echo "Starting My Job....."
echo "Installing Code server !"
curl -fsSL https://code-server.dev/install.sh | sh
echo "Use code-server --link"
echo "for Getting the link to the virtual vscode.."
echo "Updating packages...."
sudo apt update
echo "Done.."
read -p "Do you wanna install xfce de ?" -n 1 -r
echo 
if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        exit
    else
        echo "Attempting to install all the stuff....."
        echo "Updating....."
        sudo apt update
        echo "Trying to install task-xfce-dektop"
        sudo apt install xfce4 xfce4-goodies
        read -p "Do you want me to set vnc server ?" -n 1 -r
        echo 
        if [[ ! $REPLY =~ ^[Yy]$ ]]
            then 
                echo "Bye Bye :)"
                exit
            else
                echo "Attempting to install tightvncserver"
                sudo apt install tightvncserver
                echo "Starting vnc sever....."
                echo
                echo "You’ll be prompted to enter and verify a password to access your machine remotely :)"
                echo
                echo "The password must be between six and eight characters long.\nPasswords more than 8 characters will be truncated automatically."
                vncserver
                read -p "Do you want me to setup everything ???"
                if [[ ! $REPLY =~ ^[Yy]$ ]]
                    then 
                        echo "Bye Bye :)"
                        exit
                    else
                        echo "Ip: "
                        echo
                        curl ipinfo.io/ip
                        echo
                        echo
                        echo
                        echo "Killing the vnc server on port 5901 if exists :)"
                        vncserver -kill :1
                        echo "Backing up the default config file to ~/.vnc/xstartup.bak"
                        mv ~/.vnc/xstartup ~/.vnc/xstartup.bak
                        echo "Creating a executable file..."
                        echo "#/bin/bash\nxrdb $HOME/.Xresources\nstartxfce4 &" >> ~/.vnc/xstartup
                        echo "Making this file executable"
                        sudo chmod +x ~/.vnc/xstartup
                        echo "Restarting Vnc server..."
                        vncserver
                    fi
            fi
    fi
