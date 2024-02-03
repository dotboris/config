# Config

## Update

```sh
# Get latest code
git checkout main
git pull

# Update flake
nix flake update -L

# Switch configuration
home-manager switch -L --flake $(pwd)#{host}

# Commit update
git add .
git commit
git push
```

## Setup existing host

### Home Manager

1. Install Nix
1. Install Home Manager
1. Clone this repository somewhere
1. Apply the home manager config

    ```sh
    home-manager switch -L --flake $(pwd)#{host}
    ```

## Define new host

TODO