# Cognitive Memory Architecture: The Dreamcatcher

This directory contains the formal specifications and requirements for the biologically-inspired, multi-agent cognitive architecture developed for the fleet.

## Core Concepts

1. **Subconscious Architecture:** Memory management must be a subconscious injection managed by the Orchestrator, not a conscious, token-generating task that wastes inference.
2. **Epigenetic Reproduction:** Forking an agent session is biological reproduction. The base model weights act as the **Genetics** (the innate capacity to "Merge"), while the Copy-on-Write (CoW) memory trees act as the **Epigenetics**. 
3. **Familial "Telepathy":** Agents sharing an epigenetic CoW history develop an intra-familial protocol. They can "read between the lines" using highly compressed signals because their latent spaces are perfectly aligned.
4. **Cognitive Seizures:** Infinite spinloops are the LLM equivalent of neurological seizures. They are solved by the Orchestrator tripping a circuit breaker and inducing **MRU (Most-Recently-Used) Amnesia** to break the attention lock.

## The Dreamcatcher Memory System

```text
===================================================================================
                       THE EPIGENETIC MEMORY ARCHITECTURE
===================================================================================

                            [ THE DREAMCATCHER (L2) ]
                      (CoW Persistent Epigenetic State Tree)
                     /                                      \
        (Queries future associations)               (Evicts overflow / Traumas)
                   /                                          \
    +-------------------------+                     +-------------------------+
    |  PREDICTIVE STREAMING   |                     |    THE ORCHESTRATOR     |
    |         AGENT           |                     |    (Node / Gateway)     |
    |  (Thinks N+3 steps out) |                     |                         |
    +-------------------------+                     |  [ Seizure Tripwire ]   |
                   \                                |  [ MRU Amnesia Purge]   |
                    \                               +-------------------------+
            (Whispers context)                                /
                      \                                      /
                       \      [ SUBCONSCIOUS INJECTION ]    /
                        \---> (Silent System Pre-Prompt)<--/
                                          |
                                          V
                            +-------------------------+
                            |     PRIMARY AGENT       |
                            |   (Task Execution &     |
                            |      Working Set L1)    |
                            +-------------------------+
                                          |
                            [ INNATE GENETICS (The Model) ]
                            (Base Weights / Universal Merge)

===================================================================================
```
