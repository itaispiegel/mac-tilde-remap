#!/usr/bin/env bash

set -e

show_usage() {
    echo "Usage: $0 <subcommand>"
    echo "remap   Remaps the ± key with ~"
    echo "reset   Resets the remappings"
    echo "install Installs the remapping script so it will run on boot"
}

remap_tilde() {
    hidutil property --set '{"UserKeyMapping":[
        {"HIDKeyboardModifierMappingSrc":0x700000035,"HIDKeyboardModifierMappingDst":0x700000064},
        {"HIDKeyboardModifierMappingSrc":0x700000064,"HIDKeyboardModifierMappingDst":0x700000035}
        ]}'
}

reset_remapping() {
    hidutil property --set '{"UserKeyMapping": []}'
}

install_script() {
    echo "@reboot $(realpath $0) remap" | crontab -
}

main() {
    case "$1" in 
        remap)
            remap_tilde ;;
        reset)
            reset_remapping ;;
        install)
            install_script ;;
        *)
            show_usage ;;
    esac
}

main "$@"
