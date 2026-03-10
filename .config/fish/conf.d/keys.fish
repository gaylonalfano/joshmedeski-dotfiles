# Keychain/secret lookups via macOS security CLI

# Context7
set -gx CONTEXT7_API_KEY (security find-generic-password -a "$USER" -s "CONTEXT7_API_KEY" -w 2>/dev/null)

# GitHub
# TODO: consolidate to GITHUB_PERSONAL_ACCESS_TOKEN
set -gx GH_PAT (security find-generic-password -a "$USER" -s "GH_PAT" -w 2>/dev/null)
set -gx GITHUB_PERSONAL_ACCESS_TOKEN $GH_PAT

# Home Assistant
set -gx HASS_URL (security find-generic-password -a "$USER" -s "HASS_URL" -w 2>/dev/null)
set -gx HASS_TOKEN (security find-generic-password -a "$USER" -s "HASS_TOKEN" -w 2>/dev/null)
