if status is-interactive
    set -g fish_greeting ""

    export PATH="$PATH:/home/alexnoll/worldbanc/private/bin"
    
    eval "$(starship init fish)"
    eval "$(zoxide init fish)"    

    alias sys-rebuild="sudo nixos-rebuild switch --flake ~/.myNixSystem"
    alias home-rebuild="home-manager switch --flake ~/.myNixSystem"
    alias fetch="clear && fastfetch --logo nixos --logo-type small"
    alias l="eza --header --icons"
    alias p="python"
    
end

function dl-album --description "Download an album as MP3 with formatted names to ~/Music and import into cliamp"
    # Ensure a URL is provided
    if test (count $argv) -lt 1
        echo "Error: Please provide a YouTube/YouTube Music playlist or album URL."
        echo "Usage: dl-album <URL>"
        return 1
    end

    set -l url $argv

    echo "Fetching metadata to resolve 'Artist - Album Name'..."
    
    # Extract Artist and Album/Playlist titles using yt-dlp's print feature
    set -l artist (yt-dlp --print "%(artist,uploader)s" --playlist-items 1 "$url" 2>/dev/null)
    set -l album (yt-dlp --print "%(album,playlist_title)s" --playlist-items 1 "$url" 2>/dev/null)

    # Sanitize and handle fallbacks if fields are missing or empty
    if test -z "$artist" -o "$artist" = "NA"
        set artist "Unknown Artist"
    end
    if test -z "$album" -o "$album" = "NA"
        set album "Unknown Album"
    end

    # Format the folder name precisely as requested: "Artist - Album Name"
    set -l folder_name "$artist - $album"
    
    # Target a directory called "Music" strictly in the user's HOME directory
    set -l dl_dir "$HOME/Music/$folder_name"
    mkdir -p "$dl_dir"

    echo "Target Folder: $dl_dir"
    echo "Downloading and converting to MP3..."

    # 1. Download tracks, convert to MP3, and name tracks as "track_number - track_name.mp3"
    yt-dlp -x --audio-format mp3 \
        --audio-quality 0 \
        --embed-thumbnail \
        --embed-metadata \
        -o "$dl_dir/%(playlist_index)s - %(title)s.%(ext)s" \
        "$url"

    if test $status -ne 0
        echo "Error: yt-dlp failed to download the album."
        return 1
    end

    # 2. Generate the M3U playlist file
    echo "Generating playlist..."
    set -l m3u_file "$dl_dir/playlist.m3u"
    echo "#EXTM3U" > "$m3u_file"
    
    # Sort files naturally by track index and append absolute paths to the M3U
    for file in (string match -v '*playlist.m3u' "$dl_dir"/* | sort -V)
        echo "$file" >> "$m3u_file"
    end

    # 3. Import natively into cliamp
    echo "Importing playlist into cliamp..."
    if command -v cliamp >/dev/null
        cliamp playlist create "$m3u_file" $folder_name
        echo "Successfully imported '$folder_name' into cliamp!"
    else
        echo "Warning: 'cliamp' command not found. Playlist saved at: $m3u_file"
    end
end

