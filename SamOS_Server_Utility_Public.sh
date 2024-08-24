#!/bin/bash

# Define the NAS mount point and device between ""
NAS_MOUNT_POINT=""
NAS_DEVICE=""

# Function to show the main menu
show_main_menu() {
    clear
    echo "--------------------------------"
    echo " HomeLab Utility Menu"
    echo "--------------------------------"
    echo "1) Docker Containers"
    echo "2) NAS Management"
    echo "3) Exit"
    echo "--------------------------------"
}

# Function to show Docker menu
show_docker_menu() {
    clear
    echo "--------------------------------"
    echo " Docker Containers Menu"
    echo "--------------------------------"
    echo "1) List Docker Containers"
    echo "2) Start Docker Container"
    echo "3) Stop Docker Container"
    echo "q) Back to Main Menu"
    echo "--------------------------------"
}

# Function to show NAS menu
show_nas_menu() {
    clear
    echo "--------------------------------"
    echo " NAS Management Menu"
    echo "--------------------------------"
    echo "1) Mount NAS Drive"
    echo "2) Restart Samba Service"
    echo "q) Back to Main Menu"
    echo "--------------------------------"
}

# Function to list all Docker containers
list_docker_containers() {
    clear
    echo "Containers:"
    docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Status}}"
}

# Function to get container ID by name
get_container_id() {
    local name="$1"
    docker ps -aqf "name=^${name}$"
}

# Function to start a Docker container
start_docker_container() {
    clear
    echo "Available containers:"
    docker ps -a --format "{{.Names}}"
    read -p "Enter the container name to start: " container_name
    container_id=$(get_container_id "$container_name")
    if [ -n "$container_id" ]; then
        docker start "$container_id" && echo "Container $container_name started."
    else
        echo "Container $container_name not found."
    fi
    read -p "Press enter to return to the Docker menu..."
}

# Function to stop a Docker container
stop_docker_container() {
    clear
    echo "Running containers:"
    docker ps --format "{{.Names}}"
    read -p "Enter the container name to stop: " container_name
    container_id=$(get_container_id "$container_name")
    if [ -n "$container_id" ]; then
        docker stop "$container_id" && echo "Container $container_name stopped."
    else
        echo "Container $container_name not found or already stopped."
    fi
    read -p "Press enter to return to the Docker menu..."
}

# Function to mount NAS drive
mount_nas_drive() {
    clear
    echo "Mounting NAS drive..."
    if mountpoint -q "$NAS_MOUNT_POINT"; then
        echo "NAS drive is already mounted at $NAS_MOUNT_POINT."
    else
        sudo mount "$NAS_DEVICE" "$NAS_MOUNT_POINT" \
        && echo "NAS drive mounted at $NAS_MOUNT_POINT." \
        || echo "Failed to mount NAS drive."
    fi
    read -p "Press enter to return to the NAS menu..."
}

# Function to restart Samba service
restart_samba_service() {
    clear
    echo "Restarting Samba service..."
    sudo systemctl restart smbd && echo "Samba service restarted." || echo "Failed to restart Samba service."
    read -p "Press enter to return to the NAS menu..."
}

# Docker menu loop
docker_menu() {
    while true; do
        show_docker_menu
        read -p "Choose an option (or q to go back): " docker_choice
        case $docker_choice in
            1) list_docker_containers; read -p "Press enter to return to the Docker menu..." ;;
            2) start_docker_container ;;
            3) stop_docker_container ;;
            q) break ;;
            *) echo "Invalid option, please try again."; read -p "Press enter to continue..." ;;
        esac
    done
}

# NAS menu loop
nas_menu() {
    while true; do
        show_nas_menu
        read -p "Choose an option (or q to go back): " nas_choice
        case $nas_choice in
            1) mount_nas_drive ;;
            2) restart_samba_service ;;
            q) break ;;
            *) echo "Invalid option, please try again."; read -p "Press enter to continue..." ;;
        esac
    done
}

# Main loop
while true; do
    show_main_menu
    read -p "Choose an option: " choice
    case $choice in
        1) docker_menu ;;
        2) nas_menu ;;
        3) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid option, please try again."; read -p "Press enter to continue..." ;;
    esac
done
