#Welcome to my helper script. This script is supposed to help with using the anime model for Real-ESRGAN.
#Right now it will only support the upscaling of images.

echo "---- Welcome to the Anime-ESRGAN helper script ----
"

#This block will check for the existence of the necessary working folders and ask for permission to create them if necessary.
if [ -d input ] && [ -d output ] && [ -d old ]
    then
        break
    else
        echo "This script was designed to work with an input and output folder,
        where you put your images in and they come out on the other end.
        A folder for the older images is also required for the script to work.
        "
        read -p "May the script create these folders for you? (y/N) " FOLDER_YN
        case $FOLDER_YN in
            [yY] | [yY][eE][sS])
                mkdir input
                mkdir output
                mkdir old
                echo "'input', 'output' and 'old' folders created"
                ;;
            [nN] | [nN][oO])
                 echo "Folders were not created. Exiting."
                 exit 0
                 ;;
            *)
                echo "Please enter a valid option (Y/N)"
                exit 0
        esac
fi

#This block declares the functions that will be called in the next block.
function upscaleAll(){
    FILES=$(ls ./input -1)
    for FILE in $FILES
         do
            ./realesrgan-ncnn-vulkan -i ./input/$FILE -o ./output/$FILE -n realesrgan-x4plus-anime
            mv ./input/$FILE ./old
    done
}

function upscaleSpecific(){
    ./realesrgan-ncnn-vulkan -i ./input/$CHOICE -o ./output/$CHOICE -n realesrgan-x4plus-anime
    mv ./input/$CHOICE ./old
}

#This block will check for images on ./input and ask if the user wants to upscale individual images or all images.
if [ -d models ] && [ -f realesrgan-ncnn-vulkan ]
    then
        ENTRIES=("all"
                "exit"
                $(ls ./input -1))
        PS3='Selection: '
        MENU=0
        while [ "$MENU" != 1 ]; do
            echo "
            Select the image to upscale:
            
            "
            select CHOICE in "${ENTRIES[@]}"; do
                case "$CHOICE" in
                    "all" )
                        echo "Upscaling all"
                        upscaleAll
                        MENU=1
                        break
                        ;;
                    "exit" )
                        echo "Exiting"
                        MENU=1
                        break
                        ;;
                    "$CHOICE" )
                        if [ -z $CHOICE ]
                            then
                                echo "Enter a valid number"
                                break
                            else
                                echo "Upscaling $CHOICE"
                                upscaleSpecific
                                MENU=1
                                break
                        fi
                        ;;
                    * )
                        echo "Enter a valid number"
                        break
                        ;;
                esac
            done
        done
        exit 0
    else
        echo "Either the models folder or realesrgan executable are missing.
        Put them in the root of this folder and try again"
fi
