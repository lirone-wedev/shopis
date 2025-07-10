# shopis

A shell utility for managing and launching Shopify theme development environments quickly.

## Features
- Save and select Shopify store handles interactively
- Remove stores from your saved list
- Launch `shopify theme dev` for a selected store
- Supports both Bash and Zsh
- Installer prevents duplicate installs and supports clean reinstalls

## Installation

1. **Clone or download this repository.**

2. **Run the installer:**
   ```sh
   bash install-shopis.sh
   ```

3. **Choose your shell:**
   - Bash (`~/.bash_profile`)
   - Zsh (`~/.zshrc`)
   - Both

4. **If shopis is already installed:**
   - The installer will detect existing function definitions.
   - You will be prompted to reinstall (which will remove the old version and add the new one), or skip.

5. **Restart your terminal** or run:
   ```sh
   source ~/.bash_profile
   # or
   source ~/.zshrc
   ```

## Usage

- Launch the interactive store selector:
  ```sh
  shopis
  ```
- Launch for a specific store:
  ```sh
  shopis <store-handle>
  ```
- Remove a store:
  ```sh
  shopis -r
  ```
- Pull theme files:
  ```sh
  shopipull
  shopipull <store-handle>
  ```

## Notes
- The installer will only add the functions to your shell profile if they are not already present, or if you choose to reinstall.
- For Zsh, the script avoids using reserved variable names (like `options`).
- Your saved stores are kept in `~/shopis_stores.json`.

---

**Enjoy fast Shopify theme development!** 