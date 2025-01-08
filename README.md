# balatro-mods

This is a collection of my hand-made mods for [Balatro](https://store.steampowered.com/app/2379780).

All mods in this repository require at least Balatro version `1.0.1n`.

## Mod list

- [first-round-joker](./first-round-joker) (First Round Joker): Ensures a specific Joker card appears in the shop during the first round.

## Installation

> ⚠️ This branch (`main`) is for development only, code here is unstable and may not work. If you want the latest
> working changes use the `release` branch instead.

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

## General troubleshooting

If youre having troubles with a specific mod, please refer to the mod directory to check troubleshooting
steps for that mod.

Just in case you can try the following things:

- Verify that you're using the latest working version of `smods` (not necessary the latest commit)
- Be sure that you are using the latest version of the mod
- Be sure that you got the mod from valid sources:
  - GitHub releases page
  - nexusmods
  - repo `release` branch
 - If using `git`, make sure you're aren't using the `main` branch.

If you can't update to the latest version of `smods` due to incompatibility with mods that
requires an earlier version of `smods`, you can create a new issue explaining your problem.

### Creating a new GitHub issue

If your can't find a solution to your problem after searching on the specific mod README
you can create a new issue here, please have into account the following:

- Specify the mod name, e.g. `first-round-joker` either on the issue label or
in its description.
- Upload or paste any screenshots or game logs of the problem you have
- In the issue description, please put the following information:
  - game version, e.g. `balatro: 1.0.1n`
  - smods version, e.g. `smods: 1.0.0~ALPHA-1307d-STEAMODDED`
  - mod version, e.g. `first-round-joker: 1.0.1n`

## License

All source code in this repository is released under the GNU General Public License version 3 or later, unless stated otherwise.
However, it includes other projects (git submodules) that may have different licenses. Please refer to the respective project
repository for their licensing information.

### Projects used (submodules)

- [balatro-mod-env](https://github.com/LnxFCA/balatro-mod-env) - Refer to its repository for license details.
