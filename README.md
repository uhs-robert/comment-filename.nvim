<p align="center">
  <img
    src="https://cdn.jsdelivr.net/gh/twitter/twemoji@14.0.2/assets/svg/1f4ac.svg"
    width="128" height="128" alt="Name emoji" />
    <img
    src="https://cdn.jsdelivr.net/gh/twitter/twemoji@14.0.2/assets/svg/1f4c4.svg"
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
Automatically adds the <strong>git project file path</strong> as a comment to the <strong>top of files</strong> when saved.
</p>

## 🎬 How it works

Triggered automatically on every save, with per-filetype control and easy toggle.

<p align="center">
<img width="499" height="221" alt="image" src="https://github.com/user-attachments/assets/fa75eecd-bbf4-4ee1-913d-d3a08c266d25" /><br />
  <strong>Example:</strong> <code>/path/to/repo/lua/comment_filename/config.lua</code>
</p>

## 💡 Why is this useful?

Having file paths as comments provides valuable context in many scenarios:

- **🤖 AI & LLM Context**: When sharing code with ChatGPT, Claude, or Copilot, the file path gives essential context about your project structure, helping AI provide more accurate suggestions
- **📋 Code Sharing**: Copy-paste snippets become self-documenting, and colleagues immediately know where the code lives without asking "which file is this?"
- **🔍 Code Review**: In NeoVim, GitHub PRs, diffs, or review tools, quickly identify which file you're viewing without checking the file tree
- **🐛 Debugging**: When logging code or tracking errors, you instantly know the source file, and especially useful in large monorepos
- **📝 Documentation**: Code examples in docs or wikis automatically reference their source location
- **🏗️ Monorepo Navigation**: Essential for projects with similar filenames across different packages (e.g., multiple `index.ts` files)
- **📸 Screenshots**: Share code screenshots with built-in attribution of where the code comes from

Think of it as automatic source attribution that follows your code everywhere it goes.

## ✨ Features

- 🔄 Automatically inserts file path comments on save at the top of the file
- 📁 Uses git-relative paths (e.g., `-- lua/comment_filename/init.lua`)
- 🎯 Smart filetype detection with 50+ supported languages
- 🚫 Skips gitignored files by default
- 🔧 Highly configurable with sensible defaults
- 🎨 Uses Neovim's `commentstring` option for accurate comment syntax
- 🌐 Global and per-buffer toggle controls

## 📦 Installation

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "uhs-robert/comment_filename.nvim",
  opts = {},
  config = function(_, opts)
    require("comment_filename").setup(opts)

    -- Optional: Set up keybindings to fit your setup (compatible with which-key.nvim auto-discovery)
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

## 🚀 Usage

Once installed, the plugin works automatically. Every time you save a file (`:w`), it will:

1. Check if the file is in a git repository
2. Calculate the repository-relative path
3. Insert a comment with the file path at the top (if not already present)

### Example

When you save a file at `/path/to/repo/src/utils/helper.js`, the plugin adds:

```javascript
// src/utils/helper.js
```

Or for Python files:

```python
# src/services/auth.py
```

And the list goes on...

## ⚙️ Configuration

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

<details>
<summary>⛔ Default Disabled Filetypes</summary><br/>

<!-- disabled:start -->

The following filetypes are disabled by default:

- `html` - Often contains templates or generated content
- `markdown`, `tex`, `latex` - Document formats where file paths are less useful

<!-- disabled:end -->
</details>

<details>
<summary>💬 Supported Languages</summary><br/>

<!-- languages:start -->

The plugin supports 50+ languages, including:

- **Web**: JavaScript, TypeScript, React (JSX/TSX), Vue, Svelte, Astro, CSS, SCSS
- **Systems**: C, C++, Rust, Go, Zig, CUDA
- **Scripts**: Lua, Python, Ruby, Perl, PHP, Bash, Zsh, Fish
- **JVM**: Java, Kotlin, Scala, Groovy
- **Functional**: Haskell, Elixir, OCaml, Clojure, F#
- **Config**: SQL, TOML, Nginx, Dockerfile, Makefile, Nix

And many more! See [config.lua](lua/comment_filename/config.lua) for the complete list.

<!-- languages:end -->
</details>

## 💻️ Commands

### User Commands

- `:CommentFilenameToggle` - Toggle the plugin globally (on/off)
- `:CommentFilenameBufferToggle` - Toggle the plugin for the current buffer only

### 🎹 Keybindings

The plugin does not set up keybindings automatically. See the [Installation](#installation) section for examples on how to set up keybindings in your plugin manager's config function.

The keybindings shown use `vim.keymap.set()`, which is compatible with which-key.nvim's auto-discovery feature. If you prefer to explicitly register with which-key, you can use:

```lua
require("which-key").add({
  { "<leader>uh", "<cmd>CommentFilenameToggle<cr>", desc = "Toggle Comment Filename (global)" },
  { "<leader>uH", "<cmd>CommentFilenameBufferToggle<cr>", desc = "Toggle Comment Filename (buffer)" },
})
```

### 🔧 API Functions

If you're into this sort of thing, here are the options you can play with:

```lua
local cf = require("comment_filename")

cf.enable()   -- Enable globally
cf.disable()  -- Disable globally
cf.toggle()   -- Toggle global state
```
