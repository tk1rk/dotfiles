# dots

## ZPM - Ultra-Fast Zsh Plugin Manager ⚡

A cutting-edge, high-performance Zsh plugin manager with robust error handling, parallel operations, and lazy loading support.

### ✨ Features

- **Blazingly Fast**: Parallel plugin installation and updates with configurable job limits
- **Lazy Loading**: Load plugins on-demand to minimize shell startup time
- **Robust Error Handling**: Comprehensive error checking and logging
- **Simple API**: Clean, intuitive commands
- **Multiple Plugin Formats**: GitHub shorthand, full URLs, branch support
- **Smart Plugin Discovery**: Automatically finds and sources plugin files
- **Beautiful Output**: Colored terminal output with clear status indicators
- **Zero Dependencies**: Only requires `git` and `zsh`

### 🚀 Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/zpm ~/.zpm-source

# Source ZPM in your ~/.zshrc
echo 'source ~/.zpm-source/zpm.zsh' >> ~/.zshrc

# Reload your shell
source ~/.zshrc
```

Or install just the script:

```bash
# Download the script
curl -o ~/.zpm.zsh https://raw.githubusercontent.com/yourusername/zpm/main/zpm.zsh

# Add to ~/.zshrc
echo 'source ~/.zpm.zsh' >> ~/.zshrc

# Reload
source ~/.zshrc
```

### 📖 Usage

#### Install Plugins

```bash
# Install from GitHub (shorthand)
zpm install zsh-users/zsh-autosuggestions

# Install from specific branch
zpm install zdharma-continuum/fast-syntax-highlighting@main

# Install multiple plugins at once (parallel)
zpm install \
  zsh-users/zsh-autosuggestions \
  zdharma-continuum/fast-syntax-highlighting \
  zsh-users/zsh-completions

# Install from full URL
zpm install https://github.com/romkatv/powerlevel10k.git
```

#### Load Plugins

```bash
# Load plugins (add to ~/.zshrc)
zpm load zsh-autosuggestions
zpm load fast-syntax-highlighting
zpm load zsh-completions
```

#### Lazy Loading (Optimize Startup Time)

```bash
# Lazy load a plugin when a specific command is used
zpm_lazy_load nvm nvm node npm

# This will only load the nvm plugin when you first run nvm, node, or npm
# Significantly speeds up shell startup time!
```

#### Update Plugins

```bash
# Update all plugins (parallel)
zpm update

# Update specific plugins
zpm update zsh-autosuggestions fast-syntax-highlighting
```

#### List Plugins

```bash
# Show all installed plugins with status
zpm list
```

Example output:
```
Installed Plugins:

  ● loaded  zsh-autosuggestions [main@a1b2c3d]
  ○ not loaded  fast-syntax-highlighting [main@e4f5g6h]
  ● loaded  zsh-completions [master@i7j8k9l]

➜ Total: 3 plugin(s)
```

#### Remove Plugins

```bash
# Remove one or more plugins
zpm remove zsh-completions
zpm rm plugin-name1 plugin-name2
```

#### Clean Cache

```bash
# Clean cache and optimize git repositories
zpm clean
```

#### Status & Info

```bash
# Show ZPM configuration and status
zpm status
```

### 📝 Example Configuration

Here's a complete example `~/.zshrc` configuration:

```bash
# Source ZPM
source ~/.zpm.zsh

# Install plugins (run once, then comment out or remove)
# zpm install \
#   zsh-users/zsh-autosuggestions \
#   zdharma-continuum/fast-syntax-highlighting \
#   zsh-users/zsh-completions \
#   romkatv/powerlevel10k

# Load essential plugins
zpm load powerlevel10k
zpm load zsh-autosuggestions
zpm load fast-syntax-highlighting
zpm load zsh-completions

# Lazy load heavy plugins
zpm_lazy_load nvm nvm node npm npx
```

### ⚙️ Configuration

ZPM can be configured via environment variables in your `~/.zshrc` (before sourcing ZPM):

```bash
# Set custom ZPM directory (default: ~/.zpm)
export ZPM_DIR="$HOME/.local/share/zpm"

# Set maximum parallel jobs for install/update (default: 10)
export ZPM_MAX_JOBS=20

# Enable verbose logging (default: 0)
export ZPM_VERBOSE=1

# Source ZPM
source ~/.zpm.zsh
```

### 🎯 Commands Reference

| Command | Alias | Description |
|---------|-------|-------------|
| `zpm install <plugins...>` | `zpm i` | Install one or more plugins |
| `zpm load <plugins...>` | `zpm l` | Load one or more plugins |
| `zpm update [plugins...]` | `zpm u` | Update all or specific plugins |
| `zpm remove <plugins...>` | `zpm rm` | Remove one or more plugins |
| `zpm list` | `zpm ls` | List installed plugins with status |
| `zpm clean` | - | Clean cache and optimize repositories |
| `zpm status` | `zpm info` | Show ZPM status and configuration |
| `zpm help` | - | Show help message |

### 🏗️ Plugin Format Support

ZPM supports multiple plugin URL formats:

- **GitHub Shorthand**: `user/repo` → `https://github.com/user/repo.git`
- **GitHub with Branch**: `user/repo@branch` → `https://github.com/user/repo.git` (branch: branch)
- **Full URL**: `https://github.com/user/repo.git`
- **Full URL with Branch**: `https://github.com/user/repo.git@branch`

### 🛠️ Advanced Features

#### Parallel Operations

ZPM uses parallel processing for installation and updates, making it significantly faster than sequential plugin managers:

```bash
# These run in parallel (up to ZPM_MAX_JOBS concurrent operations)
zpm install plugin1 plugin2 plugin3 plugin4 plugin5
zpm update  # Updates all plugins in parallel
```

#### Error Handling & Logging

All operations are logged to `$ZPM_DIR/zpm.log`:

```bash
# View logs
tail -f ~/.zpm/zpm.log

# Check for errors
grep ERROR ~/.zpm/zpm.log
```

#### Smart Plugin Loading

ZPM automatically discovers plugin files in this order:

1. `plugin-name.plugin.zsh`
2. `plugin-name.zsh`
3. `init.zsh`
4. `plugin-name.sh`
5. First `*.zsh` file found (if none of the above exist)

It also automatically adds `functions/` directories to `fpath`.

### 🔧 Troubleshooting

#### Plugin won't load

```bash
# Check if plugin is installed
zpm list

# Check logs for errors
tail ~/.zpm/zpm.log

# Try reinstalling
zpm remove problem-plugin
zpm install user/problem-plugin
```

#### Slow shell startup

Use lazy loading for heavy plugins:

```bash
# Instead of loading directly
# zpm load nvm

# Use lazy loading
zpm_lazy_load nvm nvm node npm
```

#### Permission errors

```bash
# Check directory permissions
ls -la ~/.zpm

# Fix if needed
chmod -R u+rwX ~/.zpm
```

### 🤝 Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

### 📄 License

See the LICENSE file for details.

### 🙏 Acknowledgments

Inspired by other great plugin managers like:
- zplug
- zinit
- antigen
- antibody

Built with a focus on speed, simplicity, and robustness.

---

**Note**: ZPM is designed to be fast, reliable, and easy to use. If you encounter any issues or have suggestions, please open an issue on GitHub!
