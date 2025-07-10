# Shopis - Shopify Store Manager

[![GitHub Repository](https://img.shields.io/badge/GitHub-lirone--wedev%2Fshopis-blue?logo=github)](https://github.com/lirone-wedev/shopis)
[![Shell](https://img.shields.io/badge/Shell-100%25-89e051)](https://github.com/lirone-wedev/shopis)

A simple bash utility to manage multiple Shopify stores and streamline theme development workflow.

## Features

- 🏪 **Store Management**: Add, select, and remove multiple Shopify stores
- 🚀 **Quick Development**: Launch theme development with interactive store selection
- 📦 **Theme Pulling**: Pull themes from stores with optional store specification
- 🔍 **Interactive Selection**: Uses `fzf` for fuzzy finding and selection
- 💾 **Persistent Storage**: Stores your shop list in a JSON file for reuse

## Prerequisites

Before using Shopis, make sure you have the following installed:

- [Shopify CLI](https://shopify.dev/themes/tools/cli/installation)
- [jq](https://stedolan.github.io/jq/) - Command-line JSON processor
- [fzf](https://github.com/junegunn/fzf) - Command-line fuzzy finder

### Installation of Prerequisites

```bash
# Install Shopify CLI
npm install -g @shopify/cli @shopify/theme

# Install jq (macOS)
brew install jq

# Install fzf (macOS)
brew install fzf

# For other platforms, check their respective documentation
```

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/lirone-wedev/shopis.git
   cd shopis
   ```

2. Make the script executable:
   ```bash
   chmod +x shopis.sh
   ```

3. Source it in your shell profile (`.bashrc`, `.zshrc`, etc.):
   ```bash
   source /path/to/shopis/shopis.sh
   ```
   Or add this line to your shell profile for permanent access.

### Alternative: Direct Download

You can also download the script directly:
```bash
curl -O https://raw.githubusercontent.com/lirone-wedev/shopis/main/shopis.sh
chmod +x shopis.sh
```

## Usage

### Store Management with `shopis`

#### Select and Launch Development Server

```bash
shopis
```

This will:
1. Show an interactive list of your stored Shopify stores
2. Allow you to select an existing store or add a new one
3. Launch `shopify theme dev` for the selected store

#### Add a New Store

When you run `shopis`, you can select "➕ Add a new store" and enter your store URL (e.g., `mystore.myshopify.com`).

#### Remove a Store

```bash
shopis -r
```

This will:
1. Show a list of all stored shops
2. Allow you to select which store to remove
3. Ask for confirmation before removal

### Theme Management with `shopipull`

#### Pull Theme from Current/Default Store

```bash
shopipull
```

Equivalent to `shopify theme pull -d`

#### Pull Theme from Specific Store

```bash
shopipull mystore.myshopify.com
```

Equivalent to `shopify theme pull --store="mystore.myshopify.com" -d`

## Data Storage

Store information is saved in `~/shopis_stores.json` as a JSON array:

```json
[
  "mystore.myshopify.com",
  "anothershop.myshopify.com",
  "teststore.myshopify.com"
]
```

## Examples

### Typical Workflow

1. **First time setup** - Add your stores:
   ```bash
   shopis
   # Select "➕ Add a new store"
   # Enter: mystore.myshopify.com
   ```

2. **Daily development** - Quick store selection:
   ```bash
   shopis
   # Use arrow keys or type to select your store
   # Press Enter to launch development server
   ```

3. **Pull latest theme**:
   ```bash
   shopipull mystore.myshopify.com
   ```

4. **Clean up unused stores**:
   ```bash
   shopis -r
   # Select the store you want to remove
   # Confirm with 'y'
   ```

### Sample Session

```bash
$ shopis
Select Shopify store (3 total) > 
  mystore.myshopify.com
  testshop.myshopify.com  
  demo-store.myshopify.com
> ➕ Add a new store

$ shopis
Select Shopify store (3 total) > 
> mystore.myshopify.com
  testshop.myshopify.com
  demo-store.myshopify.com
  ➕ Add a new store

🚀 Launching Shopify theme dev for store: mystore.myshopify.com
```

## Troubleshooting

### Command not found
- Make sure you've sourced the script in your current shell session
- Verify the script is executable (`chmod +x shopis.sh`)

### fzf not working
- Install fzf: `brew install fzf` (macOS) or check [installation guide](https://github.com/junegunn/fzf#installation)

### jq errors
- Install jq: `brew install jq` (macOS) or check [installation guide](https://stedolan.github.io/jq/download/)

### Shopify CLI issues
- Make sure you're authenticated: `shopify auth login`
- Verify Shopify CLI installation: `shopify version`

## Contributing

Contributions are welcome! Feel free to:

- Open an issue for bug reports or feature requests
- Submit a pull request with improvements
- Star the repository if you find it useful

## Repository

Find this project on GitHub: [lirone-wedev/shopis](https://github.com/lirone-wedev/shopis)

## License

This project is open source. Please check the repository for license information. 