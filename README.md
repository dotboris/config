# Config

## Setup existing host

### Home Manager

1. Install Nix
1. Install Home Manager
1. Clone this repository somewhere
1. Apply the home manager config

    ```sh
    home-manager switch -L --flake '{...}/home-manager/hosts/{host}'
    ```

## Define new host

TODO