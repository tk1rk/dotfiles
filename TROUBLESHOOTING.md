# ZPM Troubleshooting Guide

Common issues and solutions for ZPM.

## 🔍 Quick Diagnostics

Run these commands first:

```bash
# Check ZPM status
zpm status

# View recent logs
tail -50 ~/.zpm/zpm.log

# List installed plugins
zpm list

# Check for errors
grep ERROR ~/.zpm/zpm.log
```

## 🐛 Common Issues

### Issue: Command not found: zpm

**Symptoms:**
```bash
$ zpm
zsh: command not found: zpm
```

**Solutions:**

1. **Not sourced in .zshrc**
   ```bash
   # Add to ~/.zshrc
   source ~/.zpm.zsh
   
   # Or if installed via installer
   source ~/.zpm-source/zpm.zsh
   
   # Reload shell
   source ~/.zshrc
   ```

2. **Wrong path**
   ```bash
   # Check where zpm.zsh is located
   find ~ -name "zpm.zsh" 2>/dev/null
   
   # Update path in .zshrc
   source /correct/path/to/zpm.zsh
   ```

### Issue: Plugin won't install

**Symptoms:**
```bash
$ zpm install user/repo
✗ Error: Failed to clone repo
```

**Solutions:**

1. **Check network connectivity**
   ```bash
   ping github.com
   curl -I https://github.com
   ```

2. **Try with full URL**
   ```bash
   zpm install https://github.com/user/repo.git
   ```

3. **Check if repository exists**
   ```bash
   # Visit in browser
   https://github.com/user/repo
   ```

4. **Try different branch**
   ```bash
   # Default branches might be 'main' or 'master'
   zpm install user/repo@main
   zpm install user/repo@master
   ```

5. **Check git credentials**
   ```bash
   git config --list | grep user
   ssh -T git@github.com
   ```

6. **Check disk space**
   ```bash
   df -h ~
   ```

### Issue: Plugin won't load

**Symptoms:**
```bash
$ zpm load plugin-name
✗ Error: No loadable file found for plugin 'plugin-name'
```

**Solutions:**

1. **Check if plugin is installed**
   ```bash
   zpm list
   ls -la ~/.zpm/plugins/plugin-name
   ```

2. **Install if missing**
   ```bash
   zpm install user/plugin-name
   ```

3. **Check plugin structure**
   ```bash
   # See what files are in the plugin
   ls -R ~/.zpm/plugins/plugin-name
   
   # Look for .zsh files
   find ~/.zpm/plugins/plugin-name -name "*.zsh"
   ```

4. **Manually source if needed**
   ```bash
   # Find the main file
   source ~/.zpm/plugins/plugin-name/init.zsh
   # Or whatever the main file is
   ```

5. **Check for plugin errors**
   ```bash
   # Try sourcing directly to see error
   source ~/.zpm/plugins/plugin-name/plugin-name.zsh
   ```

### Issue: Slow shell startup

**Symptoms:**
- Shell takes several seconds to start
- Noticeable delay when opening new terminal

**Solutions:**

1. **Use lazy loading**
   ```bash
   # Instead of
   zpm load nvm
   
   # Use
   zpm_lazy_load nvm nvm node npm
   ```

2. **Profile your startup**
   ```bash
   # Add to top of .zshrc
   zmodload zsh/zprof
   
   # Add to bottom of .zshrc
   zprof
   
   # Open new shell to see timing
   ```

3. **Load fewer plugins**
   ```bash
   # Comment out plugins you don't use
   # zpm load rarely-used-plugin
   ```

4. **Use async loading** (manual)
   ```bash
   (
       zpm load heavy-plugin
   ) &
   ```

### Issue: Plugin update fails

**Symptoms:**
```bash
$ zpm update
✗ Error: Failed to update plugin-name
```

**Solutions:**

1. **Check git status**
   ```bash
   cd ~/.zpm/plugins/plugin-name
   git status
   git remote -v
   ```

2. **Reset local changes**
   ```bash
   cd ~/.zpm/plugins/plugin-name
   git reset --hard HEAD
   git clean -fd
   
   # Then try update again
   zpm update plugin-name
   ```

3. **Reinstall plugin**
   ```bash
   zpm remove plugin-name
   zpm install user/plugin-name
   ```

4. **Check for upstream changes**
   ```bash
   cd ~/.zpm/plugins/plugin-name
   git fetch
   git log HEAD..origin/main  # or master
   ```

### Issue: Permission denied

**Symptoms:**
```bash
$ zpm install user/repo
✗ Error: Failed to create directory
```

**Solutions:**

1. **Check directory permissions**
   ```bash
   ls -la ~/.zpm
   ls -la ~/.zpm/plugins
   ```

2. **Fix permissions**
   ```bash
   chmod -R u+rwX ~/.zpm
   ```

3. **Check disk permissions**
   ```bash
   touch ~/.zpm/test
   rm ~/.zpm/test
   ```

4. **Run as correct user**
   ```bash
   # Don't use sudo with zpm
   # All operations should be as your user
   ```

### Issue: Logs show errors

**Symptoms:**
Log file has ERROR entries

**Solutions:**

1. **View full error context**
   ```bash
   grep -B 5 -A 5 ERROR ~/.zpm/zpm.log
   ```

2. **Check recent errors**
   ```bash
   tail -100 ~/.zpm/zpm.log | grep ERROR
   ```

3. **Enable verbose mode**
   ```bash
   export ZPM_VERBOSE=1
   zpm install user/repo
   ```

### Issue: Git conflicts

**Symptoms:**
```bash
error: Your local changes would be overwritten by merge
```

**Solutions:**

1. **Stash changes and update**
   ```bash
   cd ~/.zpm/plugins/plugin-name
   git stash
   zpm update plugin-name
   ```

2. **Reset to clean state**
   ```bash
   cd ~/.zpm/plugins/plugin-name
   git reset --hard origin/main
   ```

3. **Remove and reinstall**
   ```bash
   zpm remove plugin-name
   zpm install user/plugin-name
   ```

## 🧹 Maintenance

### Clean up ZPM

```bash
# Remove cache
zpm clean

# Remove unused plugins
zpm remove unused-plugin

# Optimize git repositories
cd ~/.zpm/plugins/*
for dir in */; do
    cd "$dir"
    git gc --aggressive
    cd ..
done
```

### Reset ZPM completely

```bash
# Backup plugin list first
zpm list > ~/zpm-plugins-backup.txt

# Remove ZPM directory
rm -rf ~/.zpm

# Reload ZPM (will reinitialize)
source ~/.zshrc

# Reinstall plugins
cat ~/zpm-plugins-backup.txt
# Then manually reinstall needed plugins
```

## 🔧 Advanced Debugging

### Enable debug mode

```bash
# In .zshrc before sourcing ZPM
export ZPM_VERBOSE=1

# Or temporarily
ZPM_VERBOSE=1 zpm install user/repo
```

### Trace execution

```bash
# Enable zsh tracing
set -x
zpm install user/repo
set +x
```

### Check function definition

```bash
# See what a function does
which zpm
which zpm_install
```

### Test in clean environment

```bash
# Start zsh without loading .zshrc
zsh -f

# Source only ZPM
source ~/.zpm.zsh

# Test command
zpm install user/repo
```

## 📊 Performance Issues

### Profile plugin loading

```bash
# Time each plugin load
for plugin in plugin1 plugin2 plugin3; do
    time zpm load "$plugin"
done
```

### Check what's loaded

```bash
# See loaded plugins
zpm list

# See what's in memory
echo ${(kv)ZPM_PLUGINS}
```

### Optimize configuration

```bash
# Move heavy operations to background
(
    # Heavy initialization
    some_slow_command
) &

# Continue with fast operations
zpm load fast-plugin
```

## 🆘 Getting Help

If none of these solutions work:

1. **Check the logs**
   ```bash
   cat ~/.zpm/zpm.log
   ```

2. **Create a minimal test case**
   ```bash
   # Test with single plugin
   export ZPM_DIR=/tmp/zpm-test
   source ~/.zpm.zsh
   zpm install user/repo
   ```

3. **Gather information**
   - ZPM version (check first line of zpm.zsh)
   - OS and version: `uname -a`
   - Zsh version: `zsh --version`
   - Git version: `git --version`
   - Error messages from logs
   - Steps to reproduce

4. **Report issue**
   - Open an issue on GitHub
   - Include all gathered information
   - Describe expected vs actual behavior

## 💡 Tips

1. **Keep ZPM updated**
   ```bash
   cd ~/.zpm-source
   git pull
   source ~/.zshrc
   ```

2. **Regular maintenance**
   ```bash
   # Weekly
   zpm update
   
   # Monthly
   zpm clean
   ```

3. **Backup configuration**
   ```bash
   cp ~/.zshrc ~/.zshrc.backup
   zpm list > ~/.zpm-plugins.txt
   ```

4. **Test before committing**
   ```bash
   # Test changes in new shell
   zsh -c 'source ~/.zshrc; zpm list'
   ```

---

Still having issues? Open an issue with detailed information and we'll help! 🚀
