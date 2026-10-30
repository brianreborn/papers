**Formats.** This directory’s canonical text is the Markdown below. Companion binaries (PDF and DOCX) are generated from the same source and can be added alongside this file (e.g. `HyperVirtualized_MultiTier_Coherent_Memory_Preliminary_Design.pdf`).

---

**Hyper-Virtualized Multi-Tier Coherent Memory**

*An N-ary Ownership Protocol for GPU, Host, and Firmware-Assisted Storage*

Preliminary Research and Design Document

October 2026

# Abstract

We present a preliminary research and design for a uniformly coherent, open-ended (N-ary) memory hierarchy that treats GPU-local memory, host DRAM, filesystem-backed or firmware-controlled SSD storage, and further POSIX or fabric tiers as first-class participants under a single ownership protocol. Ownership state (CPU-owned, GPU-owned, Shared, Invalid) is maintained by a lock-free software directory and enforced by IOMMU permission and coherency attributes (Intel VT-d SNP, AMD Force Coherent) together with software-visible tags stored in ignored or available page-table bits. The design extends classical TurboCache-style system-memory augmentation with explicit coherence, asynchronous invalidation (optionally off-loaded to a System Security Processor), and two concrete realisations of a large-capacity tier: a filesystem-based path and a custom-firmware path. FreeBSD is adopted as the primary host for prototyping. Side-channel exposure is treated as an inherent property of the architecture rather than an afterthought. The document is intentionally a design and research strategy; it contains no quantitative performance claims, only hypothetical improvements and a measurement agenda suitable for subsequent implementation by automated or human systems.

# 1. Introduction

Classical discrete GPU memory is physically isolated from the host. Mid-2000s technologies such as NVIDIA TurboCache and ATI HyperMemory demonstrated that system DRAM can augment a modest local framebuffer, yet they lacked coherent ownership tracking and hardware-enforced permission transitions. Modern IOMMUs supply precisely the missing primitives—read/write permission bits, snoop or force-coherent controls, and software-visible ignored or available fields—while still requiring an explicit software directory for ownership state.

Concurrently, large language model (LLM) inference and training have made the Key-Value (KV) cache and optimiser-state footprints the dominant memory wall. Existing tiering systems (HBM → DRAM → SSD) largely treat lower tiers as best-effort backing stores. The design presented here converts that ad-hoc tiering into a uniformly coherent N-ary virtual-memory system.

The central research question is whether a lock-free ownership directory, combined with IOMMU enforcement, asynchronous invalidation, and either a filesystem or custom-firmware SSD tier, can deliver coherent hyper-virtualisation of video RAM and related working sets at latencies acceptable for interactive and training workloads.

# 2. Background and Motivation

## 2.1 Historical TurboCache

NVIDIA TurboCache (and contemporary ATI HyperMemory) allowed low-end GPUs to borrow system RAM over PCI Express, advertising a larger total graphics memory than the local framebuffer. Bandwidth and latency limitations, together with the absence of coherent ownership, confined the technique to cost-reduced platforms. The present work re-examines the same idea under modern IOMMU and firmware-control assumptions.

## 2.2 IOMMU Primitives

Intel VT-d second-stage page-table entries expose R/W permission bits, an SNP (Snoop) bit, Accessed/Dirty tracking when enabled, and ignored ranges (notably bits 63:52) that software may use for tags. AMD IOMMU host page-table entries expose IR/IW permission, a Force Coherent (FC) bit, Available (AVL) fields (commonly bits 11:9), and further ignored bits. Neither architecture provides hardware-managed ownership directories; both supply the enforcement and tag-storage mechanisms required by a software directory.

## 2.3 The LLM Memory Wall

Autoregressive inference at long context is bounded by memory bandwidth and capacity. The KV cache grows linearly with sequence length and batch size; optimiser states in training routinely exceed parameter size by a factor of two to three. Contemporary systems already tier these structures across HBM, host DRAM and SSD. The contribution of the present design is to place those tiers under a single, hardware-enforced ownership protocol.

# 3. System Model and N-ary Hierarchy

The hierarchy is open-ended. Concrete realisations examined in this document are:

- L0 — GPU-local VRAM or on-package HBM
- L1 — Host DRAM
- L2 — Filesystem-backed or custom-firmware SSD (the primary large-capacity tier)
- L3 and beyond — POSIX mmap regions, memfd, userfaultfd, or fabric-attached memory, using ordinary Unix synchronisation primitives

Ownership (CPU / GPU / Shared / Invalid) and the lock-free software directory apply uniformly across every tier. There are no incoherent or best-effort layers inside the managed address space. A page may move between any pair of tiers while retaining a well-defined owner and the corresponding IOMMU permission and tag state.

# 4. Ownership Protocol and Directory

The directory is the single authoritative source of ownership. On every transition the corresponding second-stage or host page-table entry is updated (R/W or IR/IW together with SNP or FC) and the IOTLB / device-TLB is invalidated. A compact 2- or 3-bit ownership tag is stored in the ignored or AVL fields so that a thin initiator shim can detect same-owner accesses with a single load, falling back to the full directory only on mismatch.

Recommended encoding:

- 00 — Invalid / Free
- 01 — CPU-owned
- 10 — GPU-owned
- 11 — Shared

On Intel platforms the tag is placed in bits 53:52 (or a larger contiguous ignored range). On AMD platforms it occupies AVL bits 11:9, optionally combined with bit 63.

# 5. IOMMU Enforcement

Hardware supplies permission and coherency levers; software remains responsible for the directory. Changing ownership requires an explicit IOTLB (and device-TLB) invalidation. The design therefore treats invalidation latency as a first-class quantity to be hidden by an asynchronous co-pilot or by a repurposed System Security Processor.

Appendix A enumerates the precise bit positions for both major IOMMU families and the recommended tag placement.

# 6. Large-Capacity Tier Designs

## 6.1 Filesystem-Based Prototype (Primary Path)

The preferred initial prototype realises L2 through ordinary filesystem operations on FreeBSD (UFS or ZFS). Pages or regions are written to and read from files under directory control. POSIX msync, mlock and process-shared synchronisation primitives provide the necessary barriers. This path requires no firmware modification, is immediately portable, and loses only the latency advantages that a custom command set could provide. On modern systems the additional software overhead of a well-tuned filesystem is expected to be acceptable for a research prototype.

## 6.2 Custom-Firmware Path (Secondary Path)

A second design treats the SSD controller firmware as a programmable participant. The firmware exposes a page- or region-granular command set that records ownership tags, performs internal buffer management, and issues completion notifications to the host directory. Because the reference platform is fully controlled, existing public reverse-engineering of popular NVMe controller firmware can be used as a starting point; further modification is assumed feasible. This path offers lower latency and direct participation in the coherence protocol at the cost of a larger trusted computing base and platform-specific engineering.

# 7. Asynchronous Invalidation and Controller Off-load

IOTLB and device-TLB invalidation is the dominant cost of an ownership transition. The design therefore includes an asynchronous co-pilot: GPU- or host-side requests are posted to a completion queue; a dedicated CPU core or a System Security Processor drains the queue and issues the necessary flushes without blocking the shader or DMA pipeline.

On platforms where the AMD Platform Security Processor or Intel CSME/ME firmware is under experimental control, a subset of directory state or invalidation work may be off-loaded to that processor. Such off-load is optional and treated as an experimental extension. Only the TPM / measured-boot related facilities from the PQFreeBSD line of work are considered in-scope for attestation of this path.

# 8. Emergent Behaviours

The combination of heterogeneous tier latencies, an explicit directory, and multi-agent control (main directory, co-pilot, optional security processor, optional firmware) produces system-level phenomena that are not programmed into any single component.

## 8.1 Latency-Induced Effective Parallelism

Memory operations issued "simultaneously" complete at staggered times. When those operations are ownership transfers, the directory and co-pilot turn the stagger into a natural pipeline: fast-tier hits retire early while slower-tier promotions continue in the background. The result is a memory-system analogue of superscalar execution—effective parallelism extracted from latency differences rather than from widened pipelines.

## 8.2 Multi-Agent Dynamics and Self-Stabilisation

When directory or invalidation work is distributed, the agents may spontaneously specialise and load-balance. Placement policies can converge toward working sets that minimise observed transition latency even though no agent was given an explicit optimisation objective. These dynamics are both an opportunity (self-tuning) and a risk (pathological oscillation or priority inversion). Instrumentation of transition traffic is therefore required so that beneficial regimes can be amplified and detrimental ones damped.

# 9. Security Considerations

Side-channel exposure is an inherent property of any design that makes ownership transitions and tier latencies observable. It is therefore treated as a first-class chapter rather than an afterthought.

## 9.1 Trusted Computing Base

The TCB expands to include the lock-free directory, the IOMMU programming path, any custom SSD firmware, and any security-processor code that participates in ownership or invalidation. Each component must be kept small, auditable, and preferably attestable. Measured boot via TPM facilities (the sole PQFreeBSD-related element retained in scope) can provide a root of trust for the optional off-load path.

## 9.2 Isolation Strengths

IOMMU permission bits together with explicit ownership give hardware-enforced isolation between CPU and GPU domains and, by extension, between mutually distrusting jobs that share physical resources. A page whose ownership has been transferred and whose permissions cleared is inaccessible to the previous owner without a further directory-mediated grant.

## 9.3 Side Channels

Ownership transitions and the staggered latencies of the N-ary hierarchy create timing channels. An adversary that can force or observe transitions may infer access patterns of co-located workloads. Because these channels arise directly from the coherence and migration mechanisms that give the system its power, they cannot be eliminated without sacrificing the design's core properties. Mitigation therefore focuses on reducing signal-to-noise ratio (quantised or randomised invalidation delays, constant-time directory operations where feasible, isolation of high-value pages into private tiers) while accepting residual leakage as an architectural characteristic that must be documented and measured.

## 9.4 Availability

An adversary that floods the directory with spurious transitions can force continuous IOTLB shoot-downs. Rate-limiting, priority queues inside the co-pilot, and the ability to fall back to coarser ownership grains are required availability controls.

# 10. Implications for LLM Inference and Training

## 10.1 Inference

The KV cache becomes a first-class citizen of the coherent hierarchy. Hot recent tokens remain GPU-owned; reusable prefixes may be marked Shared and placed in DRAM or the L2 tier; cold blocks may be demoted under directory policy. Capacity scaling observed in contemporary tiering systems can therefore be obtained while preserving stronger correctness and visibility guarantees than best-effort offload. Latency-induced effective parallelism further allows staggered promotions to overlap with decode compute.

## 10.2 Training

Parameters, optimiser states, activations and gradients can move among tiers under the same ownership protocol. Activation checkpointing and ZeRO-style sharding become directory-mediated migrations rather than engine-specific copy paths. Checkpointing itself can be performed by quiescing transitions and walking the directory, with the L2 tier serving as a fast staging area.

# 11. Prototype Strategy on FreeBSD

FreeBSD is the primary host for the research prototype. The filesystem-based L2 path maps naturally onto UFS or ZFS. IOMMU programming proceeds through the FreeBSD IOMMU framework (or VFIO-equivalent interfaces where needed). The optional security-processor and TPM paths remain experimental extensions. Two parallel prototypes are envisaged:

1. Filesystem-backed coherent tier (immediate engineering priority).
2. Custom-firmware coherent tier (dependent on availability of a suitable starting firmware image and reverse-engineering effort).

# 12. Open Research Questions and Hypothetical Evaluation

Because this document is a design and research strategy, evaluation remains hypothetical. The following questions define the measurement agenda:

- What is the end-to-end latency distribution of a coherent ownership transfer that terminates in a filesystem-backed versus a firmware-backed L2 tier?
- How much directory and invalidation traffic can be off-loaded to a System Security Processor without perturbing steady-state decode or optimiser-step rates?
- Does the stronger coherence model permit more aggressive KV-block or activation sharing than current best-effort tiering, and at what invalidation cost?
- What quantitative side-channel leakage is observable from ownership-transition timing under concurrent workloads, and which mitigations most effectively reduce it?
- Can emergent multi-agent dynamics be steered by simple policy levers toward self-stabilising placement that minimises observed transition latency?

Theoretical charts comparing capacity multiples, hypothetical promotion latencies, and isolation strength under different ownership grains will be produced as the design is refined; no minimum quantitative claims are asserted at this stage.

# 13. Conclusion

We have described a uniformly coherent, open-ended memory hierarchy in which GPU-local memory, host DRAM, filesystem- or firmware-backed SSD storage, and further POSIX or fabric tiers participate under a single ownership protocol. The design re-interprets classical TurboCache ideas under modern IOMMU, firmware-control and multi-agent assumptions, treating side channels as inherent and emergent latency-induced parallelism as a potential source of effective throughput. FreeBSD provides the prototype host; two concrete L2 realisations (filesystem and custom firmware) are retained; TPM-based attestation of optional off-load paths is the sole PQFreeBSD-related element retained in scope.

The document is offered as a research and design foundation. Subsequent implementation, measurement and refinement by human or automated systems can proceed from the architecture, protocols and open questions articulated herein.

# Appendix A — IOMMU Bit Positions for Ownership Tagging

## A.1 Intel VT-d Second-Stage Leaf Entries

Relevant fields: R (bit 0), W (bit 1), A (bit 8), D (bit 9), SNP (bit 11), physical address (bits 51:12), ignored range (bits 63:52 and selected lower bits). The ownership tag is placed in the ignored range, typically bits 53:52.

## A.2 AMD IOMMU Host Page-Table Leaf Entries (PR = 1)

Relevant fields: PR (bit 0), A/D (when enabled), AVL (bits 11:9), U (bit 59), FC (bit 60), IR (bit 61), IW (bit 62), ignored (bit 63 and selected upper ranges). The ownership tag is placed in AVL bits 11:9, optionally extended with bit 63.

## A.3 Enforcement Sequence

Directory decides new owner → update PTE permissions and tag → issue IOTLB/device-TLB invalidation → subsequent access succeeds under new permissions or faults. The directory remains authoritative; hardware supplies only enforcement and tag storage.
