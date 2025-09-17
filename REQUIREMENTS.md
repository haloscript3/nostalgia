# Requirements

This script depends on a few CLI tools. Install them before running `./radio.sh`.

Required tools:
- bash (preinstalled on macOS/Linux)
- mpv
- socat
- dialog

## macOS
### Using Homebrew (recommended)
```bash
brew update
brew install mpv socat dialog
```

### Using MacPorts
```bash
sudo port selfupdate
sudo port install mpv socat dialog
```

## Linux
### Debian/Ubuntu
```bash
sudo apt update
sudo apt install -y mpv socat dialog
```

### Fedora
```bash
sudo dnf install -y mpv socat dialog
```

### Arch/Manjaro
```bash
sudo pacman -Syu --noconfirm mpv socat dialog
```

## Verify installation
```bash
mpv --version | head -n 1
socat -V | head -n 1
dialog --version | head -n 1
```

If any of these commands fail, revisit the install steps for your OS.

## Notes
- The script uses `mpv`'s JSON IPC via a UNIX socket at `/tmp/mpv-radio-socket`.
- Some terminals may require a true TTY for `dialog`; run directly in Terminal rather than inside certain IDEs.
- If audio output is muted at the system level, use your OS mixer in addition to the in-app controls (`u`, `d`, `m`).
