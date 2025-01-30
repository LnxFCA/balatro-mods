# balatro-mods

This is a collection of my hand-made mods for [Balatro](https://store.steampowered.com/app/2379780).

All mods in this repository require at least Balatro version `1.0.1n`.

## Table of Contents
- [Introduction](#balatro-mods)
- [Mod List](#mod-list)
- [Installation](#installation)
    - [Requirements](#requirements)
    - [Methods](#installation-methods)
- [Updating](#updating)
- [Troubleshooting](#general-troubleshooting)
- [License](#license)

## Mod list

- [first-round-joker](./first-round-joker) (First Round Joker): Ensures a specific
Joker card appears in the shop during the first round.
[NexusMods](https://www.nexusmods.com/balatro/mods/105)

- [lock-the-deal](./lock-the-deal) (Lock the Deal): Adds a Lock feature to shop items,
allowing players to save cards for future rounds or re-rolls.
[NexusMods](https://www.nexusmods.com/balatro/mods/191)

## Installation

> :warning: **Development Branch Warning:** This branch (`main`) is for development only.
> Code here is unstable and may not work. For stable releases, please switch to the `release` branch.

This repository contains all my mods for **Balatro**.
Each mod is located in its respective directory
(e.g., `first-round-joker` is in the `first-round-joker` directory).

The installation steps are similar for all mods, but some mods may require specific instructions.
These will be listed in the individual mod's **README.md** under the **Installation** section.

> **Important**: If you're updating from an older version of the mod,
> please refer to the [Updating](#updating) section to ensure a clean installation and avoid issues.

---

### Requirements

Before installing any mod, ensure the following core dependencies are installed:

| Dependency          | Description                                  | Link                                                                   |
|---------------------|----------------------------------------------|------------------------------------------------------------------------|
| **smods**           | Mod loader for Balatro.                      | [GitHub Repository](https://github.com/Steamodded/smods)               |
| **lovely-injector** | Used by **smods** to inject mods at runtime. | [GitHub Repository](https://github.com/ethangreen-dev/lovely-injector) |

Refer to the respective repositories for detailed installation instructions.

> :warning: **Note**: Some mods may have additional dependencies.
> Check the mod's `README.md` for details.

Once the core dependencies are installed, locate Balatro's `Mods` directory,
which depends on your OS:

| OS            | Path                                                                                                      |
|---------------|-----------------------------------------------------------------------------------------------------------|
| Linux/Deck    | `%LIBRARY%/steamapps/compatdata/2379780/pfx/drive_c/users/steamuser/AppData/Roaming/Balatro/Mods`         |
| Default Linux | `$HOME/.steam/root/steamapps/compatdata/2379780/pfx/drive_c/users/steamuser/AppData/Roaming/Balatro/Mods` |
| Windows       | `C:\Users\%User%\AppData\Roaming\Balatro\Mods` or `%AppData%/Balatro/Mods`                               |
| macOS         | `/Users/$USER/Library/Application Support/Balatro/Mods`                                                   |


> **Note**: **Linux / Deck**: Replace `%LIBRARY%` with your Steam Library path.
If you don’t use a custom library, then use the **Default Linux** path.

For further help, visit the
[lovely-injector](https://github.com/ethangreen-dev/lovely-injector?tab=readme-ov-file#manual-installation)
project page or the [smods wiki](https://github.com/Steamodded/smods/wiki#step-3-installing-steamodded).

### Installation methods

You can install the mods in one of the following ways:

#### Method 1: Release File (Recommended)

The easiest way to install a mod is by downloading the release file from either:

- [GitHub releases page](https://github.com/LnxFCA/balatro-mods/releases)
- [NexusMods](https://next.nexusmods.com/profile/LnxFCA/mods?gameId=6217)

This method is ideal for installing a single mod.

The release file on GitHub follows the naming scheme: `%mod-dir-name%-v%VERSION%.zip`

- `%mod-dir-name%` is replaced by the mod directory name (e.g., `first-round-joker`).
- `%VERSION%` is replaced by the version number of the mod (e.g., `first-round-joker-v2.0.0.zip`).

On NexusMods, the file name is slightly different, but the version can be found in the **Files** tab.

Install steps:

1. Download the mod release from:
   - [GitHub Releases](https://github.com/LnxFCA/balatro-mods/releases)
   - [NexusMods](https://next.nexusmods.com/profile/LnxFCA/mods?gameId=6217)

2. Extract the file into your Balatro `Mods` directory (see [Requirements](#requirements) for help).

3. After extraction, you will find a directory named after the mod (e.g., `Mods/first-round-joker`).

4. The mod is now installed. You can configure it through the **smods** mods panel,
which can be accessed by clicking the **MODS** button on the game's main menu.

#### 2. Using Git

To install all mods in the repository, you can clone the `release` branch
of **balatro-mods** using Git.
This method is recommended if you want to install all available mods in the
repository at once, and it also simplifies updating all mods.

> **Note**: When using this method, it is necessary to clean up the `Mods`
> directory and reinstall the dependencies after successfully cloning the repository.

To clone the repository, run the following command:

```bash
git clone --branch release https://github.com/LnxFCA/balatro-mods.git Mods
```

To update, run the following command:

```shell
git pull origin release
```

## Updating

When updating to a new major version (e.g., from `v1.x.x` to `v2.x.x`) or a new
minor version (e.g., from `v1.1.x` to `v1.2.x`),
it’s important to follow these steps to prevent potential issues or a "dirty installation."

> **Note**: These steps are only necessary for major or minor version updates
> (e.g., `v1.x.x` → `v2.x.x` or `v1.1.x` → `v1.2.x`).
> Patch updates (e.g., `v1.1.0` → `v1.1.1`) usually only include bug fixes
> and can be applied directly.

Follow the instructions carefully to ensure the mod functions as expected:

1. **Uninstall Previous Version**:
Before installing the new version, ensure you fully uninstall the previous version.
This can usually be done by deleting the mod folder from the `Mods` directory. This
is not necessary when using the git installation method.

2. **Clean Configuration Files**:
After successfully uninstalling the old version, you need to remove the old 
configuration files from the configuration directory.
The configuration directory (`config`) is located in the same Balatro data directory
as the `Mods` folder. The configuration file will have the same name as the mod directory.
For example, the configuration file for the `first-round-joker`
mod will be located at the relative path: `Balatro/config/first-round-joker.jkr`.

3. **Install the New Version**: Follow the [installation instructions](#installation)
to install the latest version of the mod.

4. **Check for Additional Steps**: Some updates may introduce changes that require
additional steps or configuration.
Make sure to check the mod README.md for any specific instructions related to the new version.

5. **Verify the Update**: After installation, launch the game to ensure the mod is
working correctly. If you encounter any issues, please refer to the
[troubleshooting section](#general-troubleshooting) or open a new issue on the GitHub repository.

> **Note**: If you're updating from an old version, it’s strongly recommended
> to delete the mod folder completely before reinstalling to avoid potential conflicts
> with outdated files or settings. It also helps keeping the mod folder clean by
> removing unused files.

## General Troubleshooting

If you are experiencing issues with a specific mod, please check the
mod's directory for troubleshooting steps related to that mod.

In general, you can try the following:

- Verify that you are using the latest stable version of `smods`
(this may not necessarily be the latest commit).

- Ensure that you are using the latest version of the mod.

- Confirm that you downloaded the mod from a valid source:
    - The GitHub releases page.
    - Nexus Mods.
    - The repository's `release` branch.

- If using `git`, make sure you are not on the `main` branch.

If you cannot update to the latest version of `smods` due to incompatibility with
mods requiring an older version, you may create a new issue explaining your problem.

---

### Creating a new GitHub issue

If you cannot find a solution after reviewing the specific mod's README,
you can create a new issue.

Please include the following information to assist in troubleshooting:

1. **Specify the mod name**: Include the mod name, such as `first-round-joker`, 
either in the issue label or in its description.

2. **Provide visual or log evidence**: Upload or paste any relevant screenshots or
game logs that illustrate the problem.

3. **Include detailed information**: Add the following details to the issue description:

- **Mod Name**: (e.g., `first-round-joker`)
- **Game Version**: (e.g., `balatro: 1.0.1n`)
- **smods Version**: (e.g., `1.0.0~ALPHA-1307d-STEAMODDED`)
- **Mod Version**: (e.g., `first-round-joker: 1.1.1`)

By providing this information, you will help developers identify and address your issue more efficiently.

## License

All source code in this repository is released under the GNU General Public License version 3 or later, unless stated otherwise.
However, it includes other projects (git submodules) that may have different licenses. Please refer to the respective project
repository for their licensing information.

### Projects used (submodules)

- [balatro-menv](https://github.com/LnxFCA/balatro-menv) - Refer to its repository for license details.
