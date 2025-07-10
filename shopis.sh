shopis() {
  store_file="$HOME/shopis_stores.json"

  # Ensure store list file exists
  if [ ! -f "$store_file" ]; then
    echo '[]' > "$store_file"
  fi

  # Remove mode
  if [ "$1" = "-r" ]; then
    stores=$(jq -r '.[]' "$store_file")
    store_count=$(jq length "$store_file")

    if [ "$store_count" -eq 0 ]; then
      echo "❌ No stores to remove."
      return 1
    fi

    store_to_remove=$(echo "$stores" | fzf --no-info --prompt="Remove store ($store_count saved) > ")

    if [ -z "$store_to_remove" ]; then
      echo "❌ No store selected. Exiting."
      return 1
    fi

    read -p "❗ Are you sure you want to remove '$store_to_remove'? (y/n): " confirm
    if [ "$confirm" != "y" ]; then
      echo "🚫 Removal cancelled."
      return 1
    fi

    tmp=$(mktemp)
    jq --arg store "$store_to_remove" '[ .[] | select(. != $store) ]' "$store_file" > "$tmp" && mv "$tmp" "$store_file"
    echo "✅ Store '$store_to_remove' removed."
    return 0
  fi

  # Direct launch mode if store provided as argument
  if [ -n "$1" ]; then
    store_name="$1"

    # Add to saved list if not already present
    if ! jq -e --arg store "$store_name" '.[] | select(. == $store)' "$store_file" > /dev/null; then
      tmp=$(mktemp)
      jq --arg store "$store_name" '. + [$store]' "$store_file" > "$tmp" && mv "$tmp" "$store_file"
    fi

  else
    # Interactive mode with fzf
    stores=$(jq -r '.[]' "$store_file")
    store_count=$(jq length "$store_file")
    options=$(echo -e "$stores\n➕ Add a new store")

    selected_store=$(echo "$options" | fzf --no-info --prompt="Select Shopify store ($store_count saved) > ")

    if [ -z "$selected_store" ]; then
      echo "❌ No store selected. Exiting."
      return 1
    fi

    if [ "$selected_store" = "➕ Add a new store" ]; then
      read -p "➕ Enter new Shopify store handle (e.g., asfir-4x4-il): " new_store
      if [ -z "$new_store" ]; then
        echo "❌ No store entered. Exiting."
        return 1
      fi
      tmp=$(mktemp)
      jq --arg store "$new_store" '. + [$store]' "$store_file" > "$tmp" && mv "$tmp" "$store_file"
      store_name="$new_store"
    else
      store_name="$selected_store"
    fi
  fi

  echo "🚀 Launching Shopify theme dev for store: $store_name.myshopify.com"
  shopify theme dev --store="$store_name.myshopify.com"
}

shopipull() {
  if [ -z "$1" ]; then
    shopify theme pull -d
  else
    shopify theme pull --store="$1.myshopify.com" -d
  fi
}
