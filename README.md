# Anime-ESRGAN-helper
This script is supposed to help using the Real-ESRGAN anime model to upscale anime images, which you can find here:
https://github.com/xinntao/Real-ESRGAN/blob/master/docs/anime_model.md#how-to-use

This script was designed to work with a minimal folder and file configuration like this:
- .
- ├── Anime_Upscale.sh
- ├── /input
- ├── /models
- │   ├── realesrgan-x4plus-anime.bin
- │   └── realesrgan-x4plus-anime.param
- ├── /old
- ├── /output
- └── realesrgan-ncnn-vulkan

The only folders and files you need to provide are the 'model' folder and the 'realesrgan-ncnn-vulkan' file. The script ask if you want to create the remaining ones if they don't exist.
