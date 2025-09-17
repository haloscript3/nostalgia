# Terminal Radio

A tiny TUI-based internet radio player powered by `mpv` and `dialog`. Pick a station from a menu, then control volume and mute with single-key shortcuts.

## Features
- Simple station picker using `dialog`
- Plays streams with `mpv` (audio-only)
- Runtime controls via keyboard: volume up/down, mute, quit
- Easily add or edit stations in the script

## Requirements
See `REQUIREMENTS.md` for OS-specific installation commands. In short, you need:
- bash (preinstalled on macOS/Linux)
- mpv
- socat
- dialog

## Install
1. Clone the repo:
```bash
git clone https://github.com/haloscript3/nostalgia
cd nostalgia
```
2. Make the script executable:
```bash
chmod +x radio.sh
```
3. Install dependencies (see `REQUIREMENTS.md`).

## Usage
Run the script:
```bash
./radio.sh
```
- Use arrow keys to navigate, Enter to select a station.
- Controls while playing:
  - `u`: volume up
  - `d`: volume down
  - `m`: mute toggle
  - `q`: stop playback and return to menu

## Adding or editing stations
Open `radio.sh` and edit the `STATIONS` array near the top. Each entry is:
```
"Station Name|https://stream-url"
```
Example:
```
STATIONS=(
  "Future Generation|https://edge1.radyotvonline.net/shoutcast/play/fg"
  "Radio Swiss Jazz|https://stream.srg-ssr.ch/m/rsj/mp3_128"
)
```

Tip: Many stations publish their stream URLs as `.m3u` or `.pls` files. You can often use the direct stream URL found inside those playlists.

## How it works (brief)
- The script launches `mpv` with `--no-video` and an IPC socket at `/tmp/mpv-radio-socket`.
- Volume/mute commands are sent to `mpv` over that socket using `socat` and `mpv`'s JSON IPC.
- `dialog` renders the station menu in your terminal.

## Troubleshooting
- If the menu does not appear, ensure `dialog` is installed and your terminal supports it.
- If audio doesn’t play, confirm `mpv` can play the URL directly:
```bash
mpv https://example.com/stream.mp3
```
- If volume keys do nothing, check the IPC socket is created:
```bash
ls -l /tmp/mpv-radio-socket
```
Then ensure `socat` is installed and on your `PATH`.

## License
This project is licensed under the MIT License. See the `LICENSE` file for details.
