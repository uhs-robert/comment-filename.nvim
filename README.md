<p align="center">
  <img
    src="https://cdn.jsdelivr.net/gh/twitter/twemoji@14.0.2/assets/svg/1f4db.svg"
    width="128" height="128" alt="Name emoji" />
</p>
<h1 align="center">comment_filename.nvim</h1>

<p align="center">
  <a href="https://github.com/uhs-robert/comment_filename.nvim/stargazers"><img src="https://img.shields.io/github/stars/uhs-robert/comment_filename.nvim?colorA=192330&colorB=skyblue&style=for-the-badge"></a>
  <a href="https://github.com/uhs-robert/comment_filename.nvim/issues"><img src="https://img.shields.io/github/issues/uhs-robert/comment_filename.nvim?colorA=192330&colorB=khaki&style=for-the-badge"></a>
  <a href="https://github.com/uhs-robert/comment_filename.nvim/contributors"><img src="https://img.shields.io/github/contributors/uhs-robert/comment_filename.nvim?colorA=192330&colorB=8FD1C7&style=for-the-badge"></a>
  <a href="https://github.com/uhs-robert/comment_filename.nvim/network/members"><img src="https://img.shields.io/github/forks/uhs-robert/comment_filename.nvim?colorA=192330&colorB=CFA7FF&style=for-the-badge"></a>
</p>

<p align="center">
Automatically adds the git project file path, as a comment, to the top of files when saved.
</p>

## 🕶️ What does it do?

A simple plugin that runs whenever you save a file. It writes the git repository-relative file path as a comment to the top of your files on save. You can choose which filetypes to enable/disable and toggle the plugin on/off at any time.

## Features

- 🔄 Automatically inserts file path comments on save
- 📁 Uses git-relative paths (e.g., `-- lua/comment_filename/init.lua`)
- 🎯 Smart filetype detection with 50+ supported languages
- 🚫 Skips gitignored files by default
- 🔧 Highly configurable with sensible defaults
- 🎨 Uses Neovim's `commentstring` option for accurate comment syntax
- 🌐 Global and per-buffer toggle controls

## Installation

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "uhs-robert/comment_filename.nvim",
  opts = {},
  config = function(_, opts)
    require("comment_filename").setup(opts)

    -- Optional: Set up keybindings (compatible with which-key.nvim auto-discovery)
    vim.keymap.set("n", "<leader>uh", "<cmd>CommentFilenameToggle<cr>",
      { desc = "Toggle Comment Filename (global)" })
    vim.keymap.set("n", "<leader>uH", "<cmd>CommentFilenameBufferToggle<cr>",
      { desc = "Toggle Comment Filename (buffer)" })
  end,
}
```

### [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  "uhs-robert/comment_filename.nvim",
  config = function()
    require("comment_filename").setup()

    -- Optional: Set up keybindings (compatible with which-key.nvim auto-discovery)
    vim.keymap.set("n", "<leader>uh", "<cmd>CommentFilenameToggle<cr>",
      { desc = "Toggle Comment Filename (global)" })
    vim.keymap.set("n", "<leader>uH", "<cmd>CommentFilenameBufferToggle<cr>",
      { desc = "Toggle Comment Filename (buffer)" })
  end
}
```

### [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'uhs-robert/comment_filename.nvim'

" In your init.lua or in a lua block
lua << EOF
require("comment_filename").setup()

-- Optional: Set up keybindings (compatible with which-key.nvim auto-discovery)
vim.keymap.set("n", "<leader>uh", "<cmd>CommentFilenameToggle<cr>",
  { desc = "Toggle Comment Filename (global)" })
vim.keymap.set("n", "<leader>uH", "<cmd>CommentFilenameBufferToggle<cr>",
  { desc = "Toggle Comment Filename (buffer)" })
EOF
```

## Usage

Once installed, the plugin works automatically. Every time you save a file (`:w`), it will:

1. Check if the file is in a git repository
2. Calculate the repository-relative path
3. Insert a comment with the file path at the top (if not already present)

### Example

When you save a file at `/path/to/repo/src/utils/helper.js`, the plugin adds:

```javascript
// src/utils/helper.js
```

For Python files:

```python
# src/services/auth.py
```

## Configuration

The plugin comes with sensible defaults and works out of the box. You can customize it by passing options to `setup()`:

```lua
require("comment_filename").setup({
  enabled = true,              -- Enable plugin globally
  skip_gitignored = true,      -- Skip files matched by .gitignore

  -- File patterns to match (default: 60+ patterns)
  patterns = {
    "*.js",
    "*.py",
    "*.lua",
    -- ... see config.lua for full list
  },

  -- Filetype enable/disable map (default: 50+ filetypes)
  -- Filetypes not in this map default to enabled
  filetypes = {
    javascript = true,
    python = true,
    lua = true,
    html = false,        -- Disabled by default
    markdown = false,    -- Disabled by default
    -- ... see config.lua for full list
  },
})
```

### Default Disabled Filetypes

The following filetypes are disabled by default:

- `html` - Often contains templates or generated content
- `markdown`, `tex`, `latex` - Document formats where file paths are less useful

### Supported Languages

The plugin supports 50+ languages including:

**Web**: JavaScript, TypeScript, React (JSX/TSX), Vue, Svelte, Astro, CSS, SCSS

**Systems**: C, C++, Rust, Go, Zig, CUDA

**Scripts**: Lua, Python, Ruby, Perl, PHP, Bash, Zsh, Fish

**JVM**: Java, Kotlin, Scala, Groovy

**Functional**: Haskell, Elixir, OCaml, Clojure, F#

**Config**: SQL, TOML, Nginx, Dockerfile, Makefile, Nix

And many more! See [config.lua](lua/comment_filename/config.lua) for the complete list.

## Commands

### User Commands

- `:CommentFilenameToggle` - Toggle the plugin globally (on/off)
- `:CommentFilenameBufferToggle` - Toggle the plugin for the current buffer only

### Keybindings

The plugin does not set up keybindings automatically. See the [Installation](#installation) section for examples on how to set up keybindings in your plugin manager's config function.

The keybindings shown use `vim.keymap.set()` which is compatible with which-key.nvim's auto-discovery feature. If you prefer to explicitly register with which-key, you can use:

```lua
require("which-key").add({
  { "<leader>uh", "<cmd>CommentFilenameToggle<cr>", desc = "Toggle Comment Filename (global)" },
  { "<leader>uH", "<cmd>CommentFilenameBufferToggle<cr>", desc = "Toggle Comment Filename (buffer)" },
})
```

### Programmatic API

```lua
local cf = require("comment_filename")

cf.enable()   -- Enable globally
cf.disable()  -- Disable globally
cf.toggle()   -- Toggle global state
```

## How It Works

1. **BufWritePre Autocmd**: Triggers before each file save
2. **Git Integration**: Uses `git check-ignore` to skip ignored files
3. **Path Calculation**: Finds git root and calculates relative path
4. **Comment Generation**: Uses `commentstring` option or filetype-specific fallbacks
5. **Smart Insertion**: Checks for existing comments and respects shebangs/BOMs
