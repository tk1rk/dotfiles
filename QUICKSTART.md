# ZPM Quick Start Guide ⚡

Get up and running with ZPM in 5 minutes!

## 1️⃣ Install ZPM (30 seconds)

### Method A: Using the installer (Recommended)

```bash
# Clone the repository
git clone https://github.com/yourusername/zpm ~/.zpm-source

# Run the installer
cd ~/.zpm-source
./install.sh

# Reload your shell
source ~/.zshrc
```

### Method B: Manual installation

```bash
# Download ZPM
curl -o ~/.zpm.zsh https://raw.githubusercontent.com/yourusername/zpm/main/zpm.zsh

# Add to .zshrc
echo 'source ~/.zpm.zsh' >> ~/.zshrc

# Reload
source ~/.zshrc
```

## 2️⃣ Install Your First Plugins (1 minute)

```bash
# Install popular plugins (runs in parallel - very fast!)
zpm install \
  zsh-users/zsh-autosuggestions \
  zdharma-continuum/fast-syntax-highlighting \
  zsh-users/zsh-completions
```

**What just happened?** ZPM cloned these plugins in parallel from GitHub!

## 3️⃣ Load Plugins (30 seconds)

Add to your `~/.zshrc`:

```bash
# Load plugins
zpm load zsh-autosuggestions
zpm load fast-syntax-highlighting
zpm load zsh-completions
```

Reload your shell:

```bash
source ~/.zshrc
```

**What just happened?** Your plugins are now active! Try typing a command - you'll see autosuggestions and syntax highlighting.

## 4️⃣ Optimize (Optional but Recommended)

For even faster shell startup, use lazy loading:

```bash
# Add to ~/.zshrc
# Only load nvm when you actually use node/npm
zpm_lazy_load nvm nvm node npm npx
```

## ✅ Verify Installation

```bash
# Check status
zpm status

# List installed plugins
zpm list
```

You should see something like:

```
Installed Plugins:

  ● loaded  zsh-autosuggestions [main@abc123]
  ● loaded  fast-syntax-highlighting [main@def456]
  ● loaded  zsh-completions [master@ghi789]

➜ Total: 3 plugin(s)
```

## 🎯 Next Steps

### Try More Plugins

```bash
# Popular themes
zpm install romkatv/powerlevel10k
zpm load powerlevel10k

# Directory jumping
zpm install agkozak/zsh-z
zpm load zsh-z

# Better history search
zpm install zsh-users/zsh-history-substring-search
zpm load zsh-history-substring-search
```

### Keep Plugins Updated

```bash
# Update all plugins (parallel - super fast!)
zpm update

# Update specific plugin
zpm update zsh-autosuggestions
```

### Clean Up

```bash
# Remove unused plugins
zpm remove plugin-name

# Clean cache
zpm clean
```

## 📚 Learn More

- **Full Documentation**: See [README.md](README.md)
- **Advanced Features**: See [FEATURES.md](FEATURES.md)
- **Having Issues?**: See [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
- **Want to Contribute?**: See [CONTRIBUTING.md](CONTRIBUTING.md)

## 💡 Pro Tips

1. **Use lazy loading** for heavy plugins (nvm, rbenv, pyenv)
2. **Install multiple plugins at once** - they install in parallel
3. **Check logs** if something goes wrong: `tail ~/.zpm/zpm.log`
4. **Keep updated**: Run `zpm update` regularly

## 🎨 Example Configuration

Here's a complete example `~/.zshrc`:

```bash
# Source ZPM
source ~/.zpm.zsh

# Install plugins (run once, then comment out)
# zpm install \
#   romkatv/powerlevel10k \
#   zsh-users/zsh-autosuggestions \
#   zdharma-continuum/fast-syntax-highlighting \
#   zsh-users/zsh-completions \
#   agkozak/zsh-z

# Load theme first
zpm load powerlevel10k

# Load other plugins
zpm load zsh-autosuggestions
zpm load fast-syntax-highlighting
zpm load zsh-completions
zpm load zsh-z

# Lazy load heavy tools
zpm_lazy_load nvm nvm node npm npx

# Your other zsh configuration below...
```

## ⚡ Common Commands

| Command | What it does |
|---------|-------------|
| `zpm install user/repo` | Install a plugin |
| `zpm load plugin-name` | Load a plugin |
| `zpm update` | Update all plugins |
| `zpm update plugin-name` | Update specific plugin |
| `zpm list` | List installed plugins |
| `zpm remove plugin-name` | Remove a plugin |
| `zpm clean` | Clean cache |
| `zpm status` | Show ZPM info |
| `zpm help` | Show help |

## 🚀 Performance

With ZPM, installing 10 plugins takes about **10-15 seconds** (they install in parallel).

Without ZPM (sequential), it would take **60-90 seconds**.

**That's 4-6x faster!** ⚡

## 🆘 Quick Troubleshooting

### ZPM command not found?

```bash
# Make sure ZPM is sourced in ~/.zshrc
source ~/.zpm.zsh
source ~/.zshrc
```

### Plugin won't install?

```bash
# Check your internet connection
ping github.com

# Try with full URL
zpm install https://github.com/user/repo.git

# Check the logs
tail ~/.zpm/zpm.log
```

### Shell startup slow?

```bash
# Use lazy loading
zpm_lazy_load nvm nvm node npm
```

For more help, see [TROUBLESHOOTING.md](TROUBLESHOOTING.md)

---

That's it! You're now ready to use ZPM. Enjoy your fast, well-managed Zsh plugins! 🎉

For questions or issues, open an issue on GitHub.
