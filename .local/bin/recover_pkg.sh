#!/bin/bash

# Step 1: Ask user for package manager name
read -p "Enter your package manager (e.g., apt, dnf, pacman): " pkg_manager

# Step 2: Generate a list of installed packages without versions
package_list="installed_packages.txt"

# Function to get package names (without versions)
get_installed_packages() {
    case "$pkg_manager" in
    apt)
        dpkg --get-selections | awk '{print $1}' >"$package_list"
        ;;
    dnf)
        rpm -qa --qf '%{NAME}\n' | sort -u >"$package_list"
        ;;
    pacman)
        pacman -Qq >"$package_list"
        ;;
    *)
        echo "Unsupported package manager: $pkg_manager"
        exit 1
        ;;
    esac
}

# Step 3: Install packages from the list
install_packages() {
    echo "Installing packages using $pkg_manager..."
    while IFS= read -r pkg; do
        echo "Installing $pkg..."
        case "$pkg_manager" in
        apt)
            sudo apt install -y "$pkg"
            ;;
        dnf)
            sudo dnf install -y "$pkg"
            ;;
        pacman)
            sudo pacman -S --noconfirm "$pkg"
            ;;
        esac
    done <"$package_list"
}

# Ask user if they want to export or import
read -p "Do you want to (e)xport or (i)mport packages? [e/i]: " action

if [[ $action == "e" ]]; then
    get_installed_packages
    echo "Package list saved to $package_list"
elif [[ $action == "i" ]]; then
    if [[ ! -f "$package_list" ]]; then
        echo "Package list file '$package_list' not found!"
        exit 1
    fi
    install_packages
else
    echo "Invalid option. Please choose 'e' or 'i'."
fi
