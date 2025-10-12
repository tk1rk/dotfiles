# Contributing to ZPM

Thank you for considering contributing to ZPM! This document provides guidelines and instructions for contributing.

## 🐛 Reporting Bugs

If you find a bug, please open an issue with:

- A clear, descriptive title
- Steps to reproduce the issue
- Expected behavior
- Actual behavior
- Your environment (OS, zsh version, etc.)
- Relevant logs from `~/.zpm/zpm.log`

## 💡 Suggesting Features

Feature requests are welcome! Please open an issue describing:

- The feature you'd like to see
- Why it would be useful
- How it might work

## 🔧 Development Setup

1. Fork and clone the repository:
```bash
git clone https://github.com/yourusername/zpm.git
cd zpm
```

2. Make your changes to `zpm.zsh`

3. Test your changes:
```bash
# Set up test environment
export ZPM_DIR="/tmp/zpm-test"

# Source the script
source ./zpm.zsh

# Test functionality
zpm install zsh-users/zsh-autosuggestions
zpm list
zpm update
```

4. Run the test suite (if zsh is available):
```bash
./test.zsh
```

## 📝 Code Style

Please follow these guidelines:

- Use 4 spaces for indentation
- Keep lines under 100 characters when reasonable
- Add comments for complex logic
- Use descriptive variable names
- Follow existing code patterns
- Add error handling for new functions

### Function Naming

- Public functions: `zpm_function_name`
- Private functions: `_zpm_function_name`
- Global variables: `ZPM_VARIABLE_NAME`
- Local variables: `lowercase_with_underscores`

### Error Handling

Always include proper error handling:

```zsh
# Good
if some_command; then
    _zpm_success "Command succeeded"
else
    _zpm_error "Command failed"
    return 1
fi

# Bad
some_command
```

## 🧪 Testing

Before submitting a PR:

1. Test all modified functionality
2. Test on a clean ZPM installation
3. Verify error handling works correctly
4. Check that parallel operations work as expected
5. Ensure no breaking changes to existing behavior

## 📬 Submitting Changes

1. Create a new branch for your feature/fix:
```bash
git checkout -b feature/my-new-feature
```

2. Make your changes with clear, descriptive commits:
```bash
git commit -m "Add feature: description of feature"
```

3. Push to your fork:
```bash
git push origin feature/my-new-feature
```

4. Open a Pull Request with:
   - Clear description of changes
   - Why the changes are needed
   - Any breaking changes
   - Testing performed

## 🎯 Areas for Contribution

Looking for ideas? Here are areas that need work:

### Features
- [ ] Shell completion for zpm commands
- [ ] Plugin dependency management
- [ ] Plugin version pinning
- [ ] Automatic plugin updates (scheduled)
- [ ] Plugin health checks
- [ ] Interactive plugin selection/installation
- [ ] Plugin search functionality
- [ ] Backup/restore plugin configuration

### Improvements
- [ ] Better plugin file detection
- [ ] More comprehensive error messages
- [ ] Performance optimizations
- [ ] Better logging system
- [ ] Plugin metrics and statistics
- [ ] Unit tests
- [ ] Integration tests

### Documentation
- [ ] Video tutorial
- [ ] Troubleshooting guide
- [ ] Plugin development guide
- [ ] Performance tuning guide
- [ ] Migration guides from other plugin managers

## 📜 License

By contributing, you agree that your contributions will be licensed under the same license as the project.

## 🙏 Thank You!

Every contribution, no matter how small, is appreciated. Thank you for helping make ZPM better!

## 📞 Questions?

If you have questions about contributing, feel free to:
- Open an issue with the question
- Tag it as "question"
- We'll do our best to help!

---

Happy coding! 🚀
