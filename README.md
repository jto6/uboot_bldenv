# U-Boot Build Environment
Container for a particular u-boot build environment (eg, centOS Stream 9 + EPEL
environment for building centOS)

## Intro
Provides the basic environment for building U-Boot.

## Using

### Building the container
It is hard coded to build an aarch64 centOS Stream 9 + EPEL-next environment.

> ./build_docker_image.sh

### Installing the build environment to use the container
> ./install.sh

Note: I usually specify the -d option to put the build environment in a
directory grouping all my build environments.  eg

> ./install.sh -d /home/jon/dev/bldContainer

### Using the build environment
In the installation directory (specified in the installation step):

- Source the .alias file `source .alias`
- Build the project: `<build_container> rpmbuild -ba /app/rpmbuild/SPECS/uboot-tools.spec`
- Or enter the container and execute commands directly: `<build_container>`

### Notes
If working inside the container,
any pushes to the repo need to be made outside the container, as the container does not
have the user's push credentials.
