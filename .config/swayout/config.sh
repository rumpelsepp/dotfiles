conf_home() {
    configure_output "$(get_output_by_serial 4RFMK58E0TYS)" "1920x1200" "0" "0" "1"
    configure_output "$(get_output_by_serial 0x00000000)" "2560x1440" "1920" "0" "1.3"
}

conf_laptop() {
    configure_output "$(get_output_by_serial 0x00000000)" "2560x1440" "0" "0" "1.3"
}

conf_aisec_labor4() {
    configure_output "$(get_output_by_serial 0FFXD3AK0H6S)" "1920x1200" "0" "0" "1"
    configure_output "$(get_output_by_serial 0x00000000)" "2560x1440" "1920" "0" "1.3"
}
