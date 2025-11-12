#!/usr/bin/env bash
set -euo pipefail

MODE=${1:-once}

BASE_ARGS=(
    --date-range 2025-07-01 2025-07-01
    --max-results 50
    --relevance-threshold 0.8
    --fallback-report-limit 20
    --send-email
    --required-keywords
    LLM
    "Large Language Model"
    --receiver
    yangjunx21@gmail.com
    --log-level
    INFO
)

case "${MODE}" in
    once)
        if [[ $# -gt 0 ]]; then
            shift
        fi
        python -m paper_agent.cli "${BASE_ARGS[@]}" "$@"
        ;;
    service)
        shift
        python -m paper_agent.cli \
            "${BASE_ARGS[@]}" \
            --repeat-every-days 3 \
            --service-window-days 3 \
            "$@"
        ;;
    *)
        echo "Usage: $0 [once|service] [additional CLI args...]" >&2
        exit 1
        ;;
esac

# Example overrides retained for reference:
# python -m paper_agent.cli \
#     --date-range 2025-09-01 2025-09-10 \
#     --max-results 50 \
#     --relevance-threshold 0.8 \
#     --fallback-report-limit 20 \
#     --send-email \
#     --required-keywords "photonics" "optics" \
#     --receiver yangjunx21@gmail.com \
#     --log-level INFO

# python -m paper_agent.cli \
#     --date-range 2025-08-05 2025-08-20 \
#     --max-results 50 \
#     --relevance-threshold 0.8 \
#     --fallback-report-limit 20 \
#     --send-email \
#     --required-keywords "photonics" "optics" \
#     --receiver yangjunx21@gmail.com \
#     --log-level INFO

# python -m paper_agent.cli \
#     --sources neurips_2025 \
#     --date-range 2025-12-03 2025-12-05 \
#     --max-results 50 \
#     --send-email \
#     --fallback-report-limit 50 \
#     --receiver yangjunx21@gmail.com \
#     --log-level INFO