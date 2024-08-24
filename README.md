SamOS Server Utility

This script provides a command-line interface for managing Docker containers and NAS (Network Attached Storage) drives in a home lab environment. It offers a simple menu-based system to interact with Docker and NAS functionalities.
Features

    Docker Management:
        List all Docker containers
        Start a Docker container
        Stop a Docker container

    NAS Management:
        Mount a NAS drive
        Restart the Samba service

Requirements

    docker - Docker must be installed and running on the system.
    mount - Used for mounting the NAS device.
    systemctl - Used for managing the Samba service.

Configuration

    Edit the script to set NAS mount point and device:
        Open the script in a text editor.
        Set the NAS_MOUNT_POINT and NAS_DEVICE variables to your NAS mount point and device.

    bash

NAS_MOUNT_POINT="/path/to/mount/point"
NAS_DEVICE="/dev/sdX1"

Make the script executable:

bash

    chmod +x SamOS_Server_Utility_Public.sh

Usage

    Run the script:

    bash

    ./SamOS_Server_Utility_Public.sh

    Navigate the Menu:
        HomeLab Utility Menu: Choose between Docker management and NAS management.
        Docker Containers Menu:
            1: List Docker containers
            2: Start a Docker container
            3: Stop a Docker container
            q: Back to Main Menu
        NAS Management Menu:
            1: Mount NAS drive
            2: Restart Samba service
            q: Back to Main Menu
        3: Exit the script

License

This script is released under the MIT License. See LICENSE for more details.

Author

Basil Spence
