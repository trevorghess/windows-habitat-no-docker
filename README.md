# windows-habitat-no-docker

# Local development

### On your local laptop

1. Install Habitat
  ```
  Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
  choco install habitat -y
  ```
1. Setup habitat

  `hab setup`
1. Create working directory for building your application

  ```
  mkdir packer
  cd packer
  ```

1. Initialize plan for the application build

  `hab plan init`
1. Launch windows based studio VM. We want a 'clean throwaway environment' to build in AND want to avoid using Docker.

  ```
  kitchen converge
  kitchen login
  ```

### On the Windows Studio VM

1. Change to the mounted habitat directory

  `cd /tmp/package`

1. You can either build your app on the VM OR use the habitat studio on the VM (what's the difference?)

  ```
  hab studio enter
  ```

### In the Habitat Studio (on the VM)

1. Build the package

  `build`

### Back on your laptop

1. On your laptop in the `packer/habitat/results` dir you should find your habitat artifact file (.hart)

1. If you still need to iterate, you can change the plan then return to the habitat studio in the VM and continue to create builds.
