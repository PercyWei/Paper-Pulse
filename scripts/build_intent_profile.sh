#!/usr/bin/env bash
set -euo pipefail

# =============================================================================
# Paper Pulse: Interactive Profile Builder
# =============================================================================
# This script launches the interactive intent agent to help you build a search profile.
#
# Usage:
#   ./scripts/build_intent_profile.sh [PROFILE_NAME] [OPTIONS]
#
# Examples:
#   ./scripts/build_intent_profile.sh "llm_security"
#   ./scripts/build_intent_profile.sh "vision_models" --resume
#
# Configuration:
#   INTENT_CONFIG_DIR: Directory to store profile JSONs (default: config/intent_profiles)
# =============================================================================

# -----------------------------------------------------------------------------
# Setup Paths
# -----------------------------------------------------------------------------
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEFAULT_CONFIG_DIR="$PROJECT_ROOT/config/intent_profiles"
CONFIG_DIR="${INTENT_CONFIG_DIR:-$DEFAULT_CONFIG_DIR}"

# Ensure PYTHONPATH includes the project root
export PYTHONPATH="$PROJECT_ROOT:${PYTHONPATH:-}"

# -----------------------------------------------------------------------------
# Parse Arguments
# -----------------------------------------------------------------------------
if [[ $# -eq 0 ]]; then
    echo "Usage: $0 [PROFILE_NAME] [OPTIONS]"
    echo ""
    echo "Please provide a name for your new profile."
    echo "Example: $0 my_research_topic"
    exit 1
fi

PROFILE_NAME="$1"
shift  # Shift first arg (profile name), pass the rest to the python script

# -----------------------------------------------------------------------------
# Execution
# -----------------------------------------------------------------------------
echo "----------------------------------------------------------------"
echo "🚀 Launching Intent Profile Builder: '$PROFILE_NAME'"
echo "📂 Saving to: $CONFIG_DIR"
echo "----------------------------------------------------------------"

python -m paper_agent.intent_cli \
    --profile-name "$PROFILE_NAME" \
    --config-dir "$CONFIG_DIR" \
    "$@"
