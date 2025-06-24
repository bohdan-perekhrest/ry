# ry: the simplest ruby virtual env

## Installation

Install the files from the repo to your favorite prefix (default is `~/.local`):

``` bash
git clone https://github.com/bohdan-perekhrest/ry
cd ry
./install.sh
```

### Custom Installation Prefix

``` bash
PREFIX=/usr/local ./install.sh
```

After installation, add the following lines to your bashrc (or zshrc):

``` bash
# If you're using the default ~/.local prefix,
# make sure ~/.local/bin is on your $PATH.
export PATH="$HOME/.local/bin:$PATH"
eval "$(ry setup)"
```

or, if you don't like `eval`, you can do it manually:

``` bash
export PATH="$HOME/.local/share/ry/current/bin:$PATH"
```

### Shell Completion

**Bash completion** is automatically installed to the appropriate directory. Make sure you have bash-completion installed on your system.

**ZSH completion** is automatically installed. Make sure the completion directory is in your `$fpath`. If you're using oh-my-zsh or similar, this should work automatically.

### Custom Ruby Installation Directory

If you want to specify a different directory for installing rubies:

```bash
# rubies are installed into $RY_DATA/rubies by default
# where RY_DATA defaults to $XDG_DATA_HOME/ry or $HOME/.local/share/ry
export RY_RUBIES="$HOME/.rubies"
```

## Usage

Ry is a bit different from [other][rvm] [version][rbenv] [managers][nvm]. The major design goal of ry is to be explicit, unobtrusive, and easy to query. In the vein of the [n][] package manager for node, there are no subshells, and the only thing it needs to add to your environment is a single entry to your `$PATH` (also tab completion if you like).

[rvm]: http://rvm.io/
[nvm]: https://github.com/creationix/nvm
[rbenv]: https://github.com/sstephenson/rbenv
[n]: https://github.com/visionmedia/n

### Installing Ruby versions

Ry requires `ruby-build` to install Ruby versions. Make sure you have it installed first.

``` bash
ry install 3.1.0
ry install 3.0.4 ruby-3.0.4
```

This installs Ruby 3.1.0 and Ruby 3.0.4 (with a custom name). To switch to a ruby version:

``` bash
ry use 3.1.0
```

### Available Commands

- `ry` or `ry list` - List installed Ruby versions
- `ry current` - Show current Ruby version
- `ry use <version>` - Switch to the specified Ruby version
- `ry install <version> [<name>]` - Install a Ruby version using ruby-build
- `ry uninstall <version>` - Remove a Ruby version
- `ry system` - Switch to system Ruby
- `ry setup` - Output shell commands to add Ruby to PATH

### Examples

``` bash
# List installed rubies
ry

# Install Ruby 3.1.0
ry install 3.1.0

# Install Ruby with custom name
ry install 3.0.4 my-ruby

# Switch to Ruby 3.1.0
ry use 3.1.0

# Check current Ruby
ry current

# Switch back to system Ruby
ry system

# Remove a Ruby version
ry uninstall 3.0.4
```

For more information, see `ry help`.

## Developing

All of the magic is in the bash script `bin/ry`. Here are a couple of bash features I use that aren't common elsewhere:

* Poor man's namespacing - the character `:` is a perfectly valid character to use in a bash function's name. All of ry's subcommands are implemented as functions looking like `ry::foo`. At the bottom of the file is the function `ry` which essentially delegates to `ry::$1` - so to add a new subcommand, all you need to do is define the bash function and document it in `ry::help`.

* Piping from heredocs is awesome. The syntax `cmd <<<"$variable"` runs `cmd` with stdin as the content of `$variable`. I use this extensively, and you should too.
