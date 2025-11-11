# python -m paper_agent.cli \
#     --date-range 2025-11-01 2025-11-10  \
#     --max-results 50 \
#     --relevance-threshold 0.8 \
#     --fallback-report-limit 20 \
#     --send-email \
#     --required-keywords LLM "Large Language Model" \
#     --receiver yangjunx21@gmail.com \ 2287401335@qq.com
#     --log-level INFO

# python -m paper_agent.cli \
#     --date-range 2025-09-01 2025-09-10  \
#     --max-results 50 \
#     --relevance-threshold 0.8 \
#     --fallback-report-limit 20 \
#     --send-email \
#     --required-keywords "photonics" "optics" \
#     --receiver yangjunx21@gmail.com \
#     --log-level INFO

python -m paper_agent.cli \
    --sources neurips_2025 \
    --date-range 2025-12-03 2025-12-05  \
    --max-results 50 \
    --relevance-threshold 0.8 \
    --fallback-report-limit 20 \
    --send-email \
    --required-keywords "photonics" "optics" \
    --receiver yangjunx21@gmail.com \
    --log-level INFO

# python -m paper_agent.cli \
#     --sources neurips_2025 \
#     --date-range 2025-12-03 2025-12-05 \
#     --max-results 500 \
#     --send-email \
#     --fallback-report-limit 50 \
#     --receiver yangjunx21@gmail.com \
#     --log-level INFO