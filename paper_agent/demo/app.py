from __future__ import annotations

import streamlit as st

from ..models import PipelineSettings
from ..pipeline import generate_recommendations


st.set_page_config(page_title="Paper Agent Demo", layout="wide")
st.title("📄 Paper Agent Demo")
st.write("Enter research topics to automatically fetch papers and generate recommendation emails.")

with st.sidebar:
    st.header("Configuration")
    topics_input = st.text_area("Research Focus (one per line, optional)", "LLM Safety")
    max_results = st.slider("Papers per topic", min_value=1, max_value=20, value=6)
    send_email = st.checkbox("Send email when complete", value=False)
    receiver = st.text_input("Receiver email (optional, uses default config if empty)")
    run_button = st.button("Run Recommendation")

if run_button:
    topics = [topic.strip() for topic in topics_input.splitlines() if topic.strip()]
    if not topics:
        topics = ["LLM Safety"]
    with st.spinner("Fetching, parsing, and calling LLM..."):
        try:
            result = generate_recommendations(
                PipelineSettings(
                    topics=topics,
                    max_results_per_topic=max_results,
                    send_email=send_email,
                    receiver_email=receiver or None,
                )
            )
        except Exception as exc:  # pylint: disable=broad-except
            st.error(f"Execution failed: {exc}")
            st.stop()

    st.success("Processing complete!")
    st.subheader("Recommendation Email Subject")
    st.write(result.email_subject)

    st.subheader("Recommendation Email Body (Markdown)")
    st.markdown(result.email_body)

    st.subheader("Ranking Results")
    for paper in result.papers:
        with st.expander(f"{paper.rank}. {paper.paper.title}"):
            st.markdown(
                f"- Link: [{paper.paper.link}]({paper.paper.link})\n"
                f"- Authors: {', '.join(paper.paper.authors)}\n"
                f"- Published: {paper.paper.published.strftime('%Y-%m-%d')}\n"
                f"- arXiv Categories: {', '.join(paper.paper.categories) if paper.paper.categories else 'Not provided'}\n"
                f"- LLM Topic: {paper.main_topic or 'Other'}\n"
                f"- Relevance Score: {paper.relevance_score:.2f}\n"
                f"- Ranking Score: {paper.score:.2f}\n"
                f"- LLM Explanation: {paper.reasoning or 'None'}"
            )

