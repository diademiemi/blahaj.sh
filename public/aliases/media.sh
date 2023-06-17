function  urldecode ()
{
  echo -e "$(sed 's/+/ /g;s/%\(..\)/\\x\1/g;')"
}

function  m3ufmt () {
    ## Description: Format m3u playlist
    # This fixes the following issues in m3u playlist file:
    #   - Removes file:// prefix
    #   - URL decodes the file path
    #   - Removes the #EXTINF line
    #   - Removes the #EXTM3U line
    #   - Removes empty lines
    # It will also create a backup of the original file with the .bak extension
    ## Usage:
    # m3ufmt <file1> <file2> <file3>
    ## Example:
    # m3ufmt *.m3u
    for f in ${@:1}; do
        mv $f $f.bak
        cat $f.bak | urldecode > $f
        sed -i 's,file://,,g' $f
        sed -i '/^\s*$/d' $f
        sed -i '/^#EXTINF/d' $f
        sed -i '/^#EXTM3U/d' $f
    done
}

fftrim () {
    ## Description: Trim video using ffmpeg
    # This will trim a video using ffmpeg.
    # The output file will have _trim before the extension.
    ## Usage:
    # fftrim <video> <start> <end>
    # fftrim <video> <start>
    ## Examples:
    # fftrim video.mp4 20   # Trim from 20 seconds on
    # fftrim video.mp4 10 30  # Trim between 10-30 seconds

    output="${1%.*}_trim.${1##*.}"
    if [ -z "$1" ]; then
        echo "No video provided"
        echo "Example: fftrim video.mp4 20   # Trim from 20 seconds on"
        return 1
    fi
    if [ -z "$2" ]; then
        echo "No start point"
        echo "Example: fftrim video.mp4 20   # Trim from 20 seconds on"
        return 1
    fi
    if [ -z "$3" ]; then
        ffmpeg -i $1 -ss $2 -vcodec copy -acodec copy "$output"
    else
        ffmpeg -i $1 -ss $2 -to $3 -vcodec copy -acodec copy "$output"
    fi
}

ffrcode () {
    ## Description: Reencode video to h264
    # I record videos with AV1 codec, but it's not supported by most video players.
    # This reencodes the video to h264, which is supported by most video players.
    # The output file will have _reencode before the extension.
    ## Usage:
    # ffrcode <video>
    ## Example:
    # ffrcode video.mp4

    output="${1%.*}_reencode.${1##*.}"
    ffmpeg -i $1 -c:v libx264 -preset fast -crf 30 -c:a aac -vf format=yuv420p -movflags +faststart "$output"
}
