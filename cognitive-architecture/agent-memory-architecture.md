# Agent Memory Architecture: The "Dream Catcher" System (V4)

This architecture models human biological memory processes to manage context, ensuring **subconscious injection**, **associative integration**, **predictive recollection**, and **seizure mitigation**.

---

## 1. The Subconscious Paradigm
Human working memory operates subconsciously. Forcing an LLM to consciously generate its memory state wastes inference compute and disrupts flow.
* The Primary Agent outputs **zero** memory-management tokens.
* The memory state is maintained by the background Orchestrator and injected silently into the peripheral context just before inference.

---

## 2. The Tri-Modal Memory State
### A. The Working Set (L1 Cache)
The strictly bounded active context (e.g., maximum 5-7 symbolic items). 
* **Subconscious Injection:** The Orchestrator silently prepends the active symbols as a transient system message.
* **Peripheral Awareness:** The Primary Agent "feels" these constraints intuitively.

### B. The Eviction Horizon & The Dream Catcher
When the Working Set exceeds capacity, the Orchestrator silently evicts the least relevant item to the Dream Catcher (a Copy-on-Write persistent state tracker).

### C. The Dream Reservoir & Cohesive Integration (L2 Cache)
During idle "Dream Cycles", background processes replay episodic events and build **synaptic links** between evicted symbols and baseline knowledge, mirroring biological REM sleep to cohesively integrate architectural rules.

---

## 3. Predictive Recollection & The Streaming Agent
1. **The Primary (Executive) Agent:** Focused entirely on step-by-step execution.
2. **The Predictive (Streaming) Agent:** A background agent that thinks *ahead* of the Primary Agent's trajectory, actively querying the Dreamcatcher and "whispering" cohesive, relevant memories back into the Primary Agent's peripheral context *before* they are needed.

---

## 4. Cognitive Seizures & The Anti-Loop Mechanism

A common failure mode in LLM agents is the "rapid-fire spinloop"—a state where the attention mechanism becomes hyper-fixated on an immediate error, resulting in identical, recursive retries. This is the computational equivalent of a neurological seizure.

To break the loop, the system implements a **Seizure/Post-Ictal Protocol**.

### The Mechanism: Induced MRU Amnesia
If the agent is seizing, feeding it more error logs only fuels the excitation loop. The system must induce localized short-term amnesia so the agent can "shake it off."
1. **Detection:** The Orchestrator hashes the last 3 actions/tool calls. If the hashes match and occur within a highly compressed time window, a Seizure is declared.
2. **The Purge:** The Orchestrator immediately intercepts the context window and **deletes** the Most-Recently-Used (MRU) episodic turns (the localized loop) and clears the active Working Set. 
3. **The Reset:** The agent wakes up with its foundational goal intact, but the immediate recursive failure path is forgotten, forcing it to calculate a new trajectory.

### Anti-Degeneracy Guardrail
To ensure the seizure system itself does not get stuck in a recursive loop (Status Epilepticus), the detection and purge mechanisms are deterministic, non-LLM operations managed entirely by the Orchestrator. If an agent experiences 3 distinct Cognitive Seizures within a single session, the Orchestrator triggers a "Deep Sleep" (hard pause), halting execution until human intervention or a full Dream Cycle consolidation occurs.
