# leamas

The missing package manager for Claude. Install AI agents and commands with a single command.

## Quick Install

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/leamas-ai/leamas.sh/main/install.sh)"
```

This installs the `leamas` CLI to `$HOME/leamas/leamas` and guides you through adding it to your PATH.

## What does leamas do?

Leamas simplifies installing Claude agents and commands. No more manual copying of files or managing complex directory structures. Just simple commands that work.

```bash
# Install a web development agent kit
$ leamas agent@web-dev
==> Downloading agent kit: web-dev
==> Installing agent kit: web-dev
==> Installed: frontend-architect.md
==> Installed: react-specialist.md
==> Installed: api-designer.md
==> Successfully installed 3 file(s) from agent kit: web-dev

# Install globally for all projects
$ leamas -g agent@devops
==> Installation complete! agent kit is available in: ~/.claude/agents/leamas/devops

# See what's available
$ leamas --help
```

## Usage

### Basic Commands

```bash
leamas --help                    # Show usage and options
leamas --list                    # List all available kits
leamas --version                 # Show version
leamas --update                  # Check for and install updates
leamas agent@<kit-name>         # Install agent kit locally
leamas -g agent@<kit-name>      # Install agent kit globally
leamas command@<kit-name>       # Install command kit locally
leamas -g command@<kit-name>    # Install command kit globally
```

### Installation Modes

**Local Installation** (default)
- Installs to `.claude/` in your current directory
- Perfect for project-specific agents
- Keeps your global environment clean

**Global Installation** (`-g` flag)
- Installs to `~/.claude/`
- Available across all your projects
- Great for commonly used agents

### Examples

```bash
# Install the frontend agent kit for your current project
leamas agent@frontend

# Install the database agent kit globally
leamas -g agent@database

# Install automation commands
leamas command@automation

# See all available kits
leamas --list

# Check for updates
leamas --update
```

## How It Works

1. **Downloads from [leamas.sh](https://leamas.sh)** - Fetches kits from `https://leamas.sh/kits`
2. **Smart caching** - Caches downloads for 24 hours for faster reinstalls
3. **Correct placement** - Puts files exactly where Claude expects them
4. **No dependencies** - Just bash and curl, nothing else
5. **Auto-updates** - Check for new versions with `leamas --update`

## Available Kits

Browse available kits at [leamas.sh](https://leamas.sh) or run `leamas --list` to see the current list.

### Agent Kits
- Collections of specialized AI agents
- Domain-specific expertise (web dev, DevOps, data science, etc.)
- Automatically invoked by Claude based on context

### Command Kits
- Workflow automation tools
- Chain multiple agents together
- Execute complex multi-step tasks

## Directory Structure

Leamas organizes kits in Claude's expected structure:

```
# Local installation (./)
.claude/
├── agents/
│   └── leamas/
│       └── {kit_name}/
│           └── *.md
└── commands/
    └── leamas/
        └── {kit_name}/
            └── *.md

# Global installation (~/)
~/.claude/
├── agents/
│   └── leamas/
│       └── {kit_name}/
│           └── *.md
└── commands/
    └── leamas/
        └── {kit_name}/
            └── *.md
```

## Creating Your Own Kits

Want to share your agents with the community? Create a kit and contribute!

### Kit Structure
```
my-awesome-kit/
├── agent1.md
├── agent2.md
├── command1.md        # Optional: if including commands
└── README.md          # Describe your kit
```

### Agent/Command Format
Each `.md` file should have YAML frontmatter:
```markdown
---
name: My Awesome Agent
description: Does awesome things for web development
---

# Agent Instructions

Your detailed agent instructions go here...
```

### Contributing Your Kit

You can contribute in two ways:

**Option 1: Submit Files Only**
1. Fork the [leamas repository](https://github.com/leamas-ai/leamas.sh)
2. Create your kit directory in `kits/agents/` or `kits/commands/`
3. Add your `.md` files and README
4. Submit a pull request

**Option 2: Submit Your Git Repository**
1. Create your kit as a separate git repository
2. Fork the [leamas repository](https://github.com/leamas-ai/leamas.sh)
3. Submit a pull request with a link to your kit repo
4. We'll review and integrate the files (not the git history)

### Kit Guidelines
- ✅ Clear, descriptive agent names
- ✅ Detailed README explaining the kit's purpose
- ✅ Well-tested agents/commands
- ✅ Follow YAML frontmatter format
- ✅ Include examples in your README

## Troubleshooting

### Command not found
After installation, make sure to add leamas to your PATH:
```bash
echo 'export PATH="$HOME:$PATH"' >> ~/.bashrc && source ~/.bashrc
# For zsh: echo 'export PATH="$HOME:$PATH"' >> ~/.zshrc && source ~/.zshrc
```

### Permission denied
```bash
chmod +x ~/leamas
```

### Can't download kits
Check your internet connection and firewall settings. Leamas needs to access `https://leamas.sh`.

## Contributing

We welcome contributions! Here's how you can help:

- **🎯 Add new kits**: Create and submit agent/command collections (see [Creating Your Own Kits](#creating-your-own-kits))
- **🐛 Report bugs**: [Open an issue](https://github.com/leamas-ai/leamas.sh/issues)
- **📖 Improve docs**: Documentation PRs are always welcome
- **💡 Share ideas**: [Join discussions](https://github.com/leamas-ai/leamas.sh/discussions)
- **🔧 Improve leamas**: Submit PRs for the CLI tool itself

### Development Setup
```bash
git clone https://github.com/leamas-ai/leamas.sh.git
cd leamas
./leamas --help  # Test the script locally
```

## Community

- **GitHub**: [github.com/leamas-ai/leamas.sh](https://github.com/leamas-ai/leamas.sh)
- **X (Twitter)**: [@leamas_ai](https://x.com/leamas_ai)
- **Reddit**: [r/leamas](https://reddit.com/r/leamas)
- **Website**: [leamas.sh](https://leamas.sh)

## License

MIT License - see [LICENSE](LICENSE) file

## Security

- ✅ **Open source** - All code is public and reviewable
- ✅ **No elevated permissions** - Doesn't require sudo
- ✅ **Limited scope** - Only writes to Claude directories
- ✅ **Transparent downloads** - See exactly what's being installed

---

Built with ✌️ for the Claude community