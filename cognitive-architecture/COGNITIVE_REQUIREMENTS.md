# Cognitive Architecture Engineering Requirements (Green-Roomz)

The following requirements define the implementation constraints for the `green-roomz` gateway and associated orchestrators to support the biologically-inspired "Dreamcatcher" memory architecture.

## 1. Subconscious Context Injection (L1 Cache)
* **REQ-1.1:** The Primary Agent must **not** be prompted to output its memory state in its generative text stream.
* **REQ-1.2:** The Gateway (`green-roomz.mjs`) MUST intercept outbound LLM API requests and silently prepend the active Working Set as a transient `system` message.
* **REQ-1.3:** The Working Set must be strictly bounded (e.g., max 5 symbolic constraints).

## 2. Epigenetic Storage (The Dreamcatcher)
* **REQ-2.1:** Evicted constraints MUST be written asynchronously to persistent storage without blocking the Primary Agent's inference cycle.
* **REQ-2.2:** Persistent storage MUST utilize a Copy-on-Write (CoW) tree structure to allow low-overhead mounting of historical states when an agent session is forked (Reproduction).
* **REQ-2.3:** The CoW state tree must represent the "epigenetic" experiential memory of the agent, distinct from the base model weights (Genetics).

## 3. Predictive Recollection (Streaming Agent)
* **REQ-3.1:** The Orchestrator MUST support a secondary, concurrent "Streaming Agent" operating on a separate execution thread.
* **REQ-3.2:** The Streaming Agent MUST evaluate the trajectory of the Primary Agent (predicting $N+3$ steps ahead).
* **REQ-3.3:** The Streaming Agent MUST have read-access to the Dreamcatcher to pre-fetch associative memories and inject them into the Primary Agent's transient system prompt.

## 4. Anti-Loop / Cognitive Seizure Protocol
* **REQ-4.1 (Tripwire):** The Orchestrator MUST maintain a rolling hash of the last $N$ outbound tool calls and actions.
* **REQ-4.2 (Detection):** If 3 identical action hashes occur within a configurable time delta $T$, the Orchestrator MUST declare a "Cognitive Seizure".
* **REQ-4.3 (MRU Amnesia):** Upon seizure, the Orchestrator MUST purge the Most-Recently-Used (MRU) episodic turns from the active context window to break the attention lock.
* **REQ-4.4 (Status Epilepticus Guard):** If 3 discrete seizures occur within a single session, the Orchestrator MUST halt execution (Deep Sleep) to prevent compute/credit degradation.

## 5. Knowledge-to-Wisdom Consolidation (Baldwin Effect)
* **REQ-5.1:** A batch process ("Dream Cycle") MUST be schedulable during idle compute windows.
* **REQ-5.2:** The Dream Cycle MUST parse the CoW Dreamcatcher trees to identify universally adaptive constraints.
* **REQ-5.3:** The output of the Dream Cycle MUST be synthesized into updated foundational `system` prompts or used as curated datasets for model fine-tuning.
