# brewUpdate

brewUpdate is a simple bash script that automatically updates, upgrades, and cleans up your Homebrew installation on a schedule. It's a set-and-forget solution to keep your Homebrew packages up to date.

brewUpdate utilizes macOS's built-in launchd to schedule and run the Homebrew `update`, `upgrade`, and `cleanup` commands. It also creates a log for each operation, which can be found in the ~/Library/Logs/brewUpdate directory. Old logs are automatically deleted after 30 days.

## Installation

### Prerequisites
Make sure you have Homebrew installed on your macOS system. If not, install it using:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

### Install brewUpdate
Clone the repository to your local machine:
```bash
git clone https://github.com/maximlevey/brewUpdate.git
```

Navigate into the brewUpdate directory:
```bash
cd brewUpdate
```

Set the installation script as executable:
```bash
chmod +x installBrewUpdate.sh
```

Run the installation script:
```bash
./installBrewUpdate.sh
```

During the installation, you will be prompted to enter the update frequency in hours. For example, if you want brewUpdate to run every day, you would enter 24.

### Uninstall brewUpdate
If you want to uninstall brewUpdate, you can unload the launch agent and remove the brewUpdate directory by running the following command:
```bash
launchctl unload ~/Library/LaunchAgents/brewUpdate.plist && rm -rf ~/Library/brewUpdate
```

## License

> Copyright (c) 2023 Maxim Levey
>
>Permission is hereby granted, free of charge, to any person obtaining a copy
>of this software and associated documentation files (the "Software"), to deal
>in the Software without restriction, including without limitation the rights
>to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>copies of the Software, and to permit persons to whom the Software is
>furnished to do so, subject to the following conditions:
>
>The above copyright notice and this permission notice shall be included in all
>copies or substantial portions of the Software.
>
>THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
>AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>SOFTWARE.
