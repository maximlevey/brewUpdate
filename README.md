# brewUpdate

brewUpdate is a simple bash script that automatically updates, upgrades, and cleans up your Homebrew installation on a schedule. It's a set-and-forget solution to keep your Homebrew packages up to date.

brewUpdate utilizes macOS's built-in launchd to schedule and run the Homebrew `update`, `upgrade`, and `cleanup` commands. It also creates a log for each operation, which can be found in the ~/Library/Logs/brewUpdate directory. Old logs are automatically deleted after 30 days.

## Requirements

Make sure you have [Homebrew](https://brew.sh/) installed on your device. If not, install it first.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

## Installation

You can clone the repository wherever you want, I usually keep it in ~/Projects/

```bash
git clone https://github.com/maximlevey/brewUpdate.git
```

`CD` to the brewUpdate directory, set the `installBrewUpdate.sh` script as executable and run.

```bash
cd brewUpdate && chmod +x installBrewUpdate.sh && ./installBrewUpdate.sh
```
During the installation, you will be prompted to enter the update frequency in hours. For example, if you want brewUpdate to run every day, you would enter `24`

## Uninstall brewUpdate
If you want to uninstall brewUpdate, first unload the launch agent then remove the brewUpdate directory.

```bash
launchctl unload ~/Library/LaunchAgents/brewUpdate.plist && rm -rf ~/Library/brewUpdate
```

## Get in touch

If you have any questions about brewUpdate, feel free to shoot me a message on [LinkedIn](https://www.linkedin.com/in/maximlevey/) or in the [Mac Admins Slack.](https://macadmins.slack.com)

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
