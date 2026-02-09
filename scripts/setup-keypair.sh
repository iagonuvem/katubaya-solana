#!/bin/bash

# Setup script for creating Solana keypair for local development

set -e

KEYPAIR_PATH="$HOME/.config/solana/id.json"

echo "🔑 Setting up Solana keypair for local development..."

# Create directory if it doesn't exist
mkdir -p "$HOME/.config/solana"

# Check if keypair already exists
if [ -f "$KEYPAIR_PATH" ]; then
    echo "✅ Keypair already exists at: $KEYPAIR_PATH"
    echo "   Public key: $(solana address -k "$KEYPAIR_PATH" 2>/dev/null || echo 'Unable to read')"
    read -p "   Do you want to create a new one? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "   Keeping existing keypair."
        exit 0
    fi
    echo "   Backing up existing keypair..."
    mv "$KEYPAIR_PATH" "${KEYPAIR_PATH}.backup.$(date +%s)"
fi

# Generate new keypair
echo "📝 Generating new keypair..."
solana-keygen new --outfile "$KEYPAIR_PATH" --no-bip39-passphrase

# Display the public key
PUBKEY=$(solana address -k "$KEYPAIR_PATH")
echo "✅ Keypair created successfully!"
echo "   Location: $KEYPAIR_PATH"
echo "   Public key: $PUBKEY"
echo ""
echo "💡 To fund this wallet for localnet testing, run:"
echo "   solana airdrop 2 $PUBKEY --url localhost"
echo ""
echo "   (Make sure solana-test-validator is running first)"
