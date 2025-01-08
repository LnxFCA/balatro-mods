# balatro-mods

This is a collection of my hand-made mods for [Balatro](https://store.steampowered.com/app/2379780).

All mods in this repository require at least Balatro version `1.0.1n`.

## Mod list

- [first-round-joker](./first-round-joker) (First Round Joker): Ensures a specific Joker card appears in the shop during the first round.

## Installation

> ⚠️ This branch (`main`) is for development only, code here is unstable and may not work. If you want the latest
> working changes use the `release` branch instead.

> Please note that mods here requires the latest working version of `smods` (not necessary the latest git version), if you have any problem with the mod
> try updating your `smods` version, if you can't update `smods` due to having mods depending on a later version
> of the former, you can try to create a new issue here.

To know where to install Balatro mods, see the
[lovely-injector](https://github.com/ethangreen-dev/lovely-injector?tab=readme-ov-file#manual-installation)
project, or the [Steamodded Wiki](https://github.com/Steamodded/smods/wiki/#step-3-installing-steamodded).
Once you have the `Mods` directory located on your machine, you're ready to go.

There are two ways to install mods from this repository: the easy way and the hard way.

### Easy way

The easy way consists of downloading the latest individual release of the mod of
your choice [here](https://github.com/LnxFCA/balatro-mods/releases). They are named
after the mod folder, e.g., `first-round-joker-v1.0.0.zip`.

Once you have downloaded the file, you can extract its contents inside the `Mods` folder
directly and enjoy.

### Hard way

The hard way is intended for developers or advanced users who have a basic understanding of `git`.

Users should clone the `release` branch of the repository since the `main` branch
has extra code that helps with development but can cause problems when running
the mod.

To clone the `release` branch, you can execute the following command in the command-line:

```sh
git clone -b release https://github.com/LnxFCA/balatro-mods.git
```

After successfully cloning the repository, users can get the latest version of the mods by using:

```sh
git pull --all
```

The `release` branch doesn't have any files like `README.md`, etc. It only contains the most recent version of all mods (code that isn't in a public release yet).

Developers who want to test things out can clone this repository by using the following command:

```sh
git clone --recurse-submodules https://github.com/LnxFCA/balatro-mods.git
```

## License

All source code in this repository is released under the GNU General Public License version 3 or later, unless stated otherwise.
However, it includes other projects (git submodules) that may have different licenses. Please refer to the respective project
repository for their licensing information.

### Projects used (submodules)

- [balatro-mod-env](https://github.com/LnxFCA/balatro-mod-env) - Refer to its repository for license details.
