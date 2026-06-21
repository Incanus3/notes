# Hyprland

## Documentation / wiki

- https://wiki.hypr.land - official Hyprland wiki.
- https://wiki.archlinux.org/title/Hyprland - Arch Wiki Hyprland page.
- https://danklinux.com/docs/ - danklinux Hyprland docs.

## Dotfiles / starter setups

- https://github.com/end-4/dots-hyprland (last update 06/2026) - usability-first Hyprland dotfiles.
- https://ii.clsty.link/en/ - illogical-impulse setup docs.
- https://ii.clsty.link/en/ii-qs/03config/ - illogical-impulse config reference.
- https://ii.clsty.link/en/ii-qs/01setup/#post-installation - illogical-impulse setup / post-installation guide.
- https://github.com/criticalart/calos (last update 06/2026) - pre-configured Arch Linux + Hyprland starter setup.

## Components / themes

- https://github.com/uiriansan/SilentSDDM (last update 06/2026) - customizable SDDM theme.
- https://nwg-piotr.github.io/nwg-shell/ - nwg-shell; probably will not use by itself, but has a ton of useful apps.

## Wayland compatibility

- https://blog.jetbrains.com/platform/2024/07/wayland-support-preview-in-2024-2/ - JetBrains Wayland support preview.
- https://github.com/hyprwm/Hyprland/issues/9355 - Hyprland issue #9355.

## CPU frequency scaling

- https://wiki.archlinux.org/title/CPU_frequency_scaling - not really related to Hyprland, but frequency scaling worked before the switch and stopped working afterwards (or maybe it worked, but governor was set to powersave, resulting in minimum frequency being used).
- Fix: install `linux-tools-meta`, edit `/etc/default/cpupower` and `/etc/cpupower-service.conf`, set performance governor in both, then enable and start `cpupower.service`.

## Impulse OS

- https://github.com/impulse-os/impulseos-live (last update 10/2024) - would be really nice, but doesn't seem to work.

## Config files

- `~/.config/hypr`
- `~/.config/quickshell`
- `~/.config/illogical-impulse`

## Useful packages

- `kde-gtk-config`
- `nwg-look`
- `nwg-displays`

## TODO

- Reinstall `hyprlauncher` once icu is updated to 78 in repo.
