# Verification log — Water Spinach working paper

All checks run 2026-09-26 (PT) from the box. Methods: NCBI E-utilities (esearch/esummary/efetch) for PubMed records and abstracts; Crossref REST API for metadata; DataCite API for arXiv DOIs; doi.org handle API (`responseCode 1` = handle exists) plus `curl -I https://doi.org/<doi>` (302 = resolver redirects to publisher). Retraction flags were checked through the PubMed publication types.

## 1. Grok-cited PMIDs (24 Sep 2026 thread)

| # | PMID | Grok said | PubMed record | Status |
|---|---|---|---|---|
| 1 | 22200874 | Quercetin inhibits A549 lung growth/apoptosis | Zheng SY et al. 2012, *Mol Med Rep* 5:822-6, "Anticancer effect and apoptosis induction by quercetin in the human lung cancer cell line A-549", doi:10.3892/mmr.2011.726 | **Verified** — title/abstract match; DOI resolves; not retracted; cited |
| 2 | 24223637 | Quercetin cuts MCF-7 breast proliferation | Deng XH et al. 2013, *Exp Ther Med* 6:1155-8, "Effects of quercetin on the proliferation of breast cancer cells and expression of survivin in vitro", doi:10.3892/etm.2013.1285 | **Verified** — title/abstract match; DOI resolves; not retracted; cited |
| 3 | 39146763 | Quercetin+chrysin on MDA-MB-231/MCF-7 | Ramos PS et al. 2024, *Biomed Pharmacother* 179:117276, "Effect of quercetin and chrysin and its association on viability and cell cycle progression in MDA-MB-231 and MCF-7 human breast cancer cells", doi:10.1016/j.biopha.2024.117276 | **Verified** — title/abstract match; DOI resolves; not retracted; cited |
| 4 | 19005980 | Quercetin on OVCAR-3 ovarian | Luo H et al. 2008, *Nutr Cancer* 60:800-9 (12 flavonoids incl. quercetin and taxifolin on OVCAR-3), doi:10.1080/01635580802100851 | **Verified** — title/abstract match; DOI resolves; not retracted; cited |
| 5 | 25096395 | Quercitrin on DLD-1 colon | Cincin ZB et al. 2015, *Pathol Oncol Res* 21:333-8, doi:10.1007/s12253-014-9825-3 | **Verified** — title/abstract match; DOI resolves; not retracted; cited |
| 6 | 28677813 | Quercetin on CT-26/MCF-7 et al. | Hashemzaei M et al. 2017, *Oncol Rep* 38:819-28 (9 lines; CT-26 and MCF-7 xenografts), doi:10.3892/or.2017.5766 | **Verified** — title/abstract match; DOI resolves; not retracted; cited |
| 7 | 32566617 | Taxifolin on A549/H1975 lung | Wang R et al. 2020, *Ann Transl Med* 8:590, doi:10.21037/atm-20-3329 | **Verified** — title/abstract match; DOI resolves; not retracted; cited |
| 8 | 32727794 | Quercetin on 13 liver lines | Hisaka T et al. 2020, *Anticancer Res* 40:4695-700, doi:10.21873/anticanres.14469 | **Verified** — title/abstract match; DOI resolves; not retracted; cited |

The three PMIDs singled out for checking (22200874, 24223637, 39146763) all match Grok's description exactly. Grok's items without PMIDs (quercetin on LNCaP/DU-145/PC-3; DHQ on SK-OV-3; taxifolin on MDA-MB-231/4T1; taxifolin on AGS) were **not verified and not cited**.

## 2. Every DOI in the bibliography

| # | Key | DOI / URL | PMID | doi.org handle | Resolver | Registry title match |
|---|---|---|---|---|---|---|
| 1 | bjeldanes1977 | 10.1126/science.327550 | 327550 | 1 (exists) | HTTP 302 | crossref: "Mutagenic Activity of Quercetin and Related Compounds" ✔ |
| 2 | alphatocopherolbetac1994 | 10.1056/NEJM199404143301501 | 8127329 | 1 (exists) | HTTP 302 | crossref: "The Effect of Vitamin E and Beta Carotene on the Incidence of Lung Can" ✔ |
| 3 | hollman1995 | 10.1093/ajcn/62.6.1276 | 7491892 | 1 (exists) | HTTP 302 | crossref: "Absorption of dietary quercetin glycosides and quercetin in healthy il" ✔ |
| 4 | omenn1996 | 10.1056/NEJM199605023341802 | 8602180 | 1 (exists) | HTTP 302 | crossref: "Effects of a Combination of Beta Carotene and Vitamin A on Lung Cancer" ✔ |
| 5 | woo1997 | 10.1016/s0009-9120(97)00112-4 | 9399024 | 1 (exists) | HTTP 302 | crossref: "Plasma Total Antioxidant Capacity in an Adult Hong Kong Chinese Popula" ✔ |
| 6 | day1998 | 10.1016/s0014-5793(98)01101-6 | 9771896 | 1 (exists) | HTTP 302 | crossref: "Deglycosylation of flavonoid and isoflavonoid glycosides by human smal" ✔ |
| 7 | kasturi1998 | no DOI; https://pubmed.ncbi.nlm.nih.gov/9748125/ | 9748125 | — | HTTP 200 (PubMed page) | PubMed record confirmed via E-utilities ✔ |
| 8 | day2000 | 10.1016/s0014-5793(00)01211-4 | 10692580 | 1 (exists) | HTTP 302 | crossref: "Dietary flavonoid and isoflavone glycosides are hydrolysed by the lact" ✔ |
| 9 | braune2001 | 10.1128/AEM.67.12.5558-5567.2001 | 11722907 | 1 (exists) | HTTP 302 | crossref: "Degradation of Quercetin and Luteolin by Eubacterium ramulus" ✔ |
| 10 | graczyk2001 | 10.1007/s004360000299 | 11199855 | 1 (exists) | HTTP 302 | crossref: "Fasciolopsiasis: is it a controllable food-borne disease?" ✔ |
| 11 | gothberg2002 | 10.1002/etc.5620210922 | 12206434 | 1 (exists) | HTTP 302 | crossref: "Accumulation of heavy metals in water spinach (Ipomoea aquatica) culti" ✔ |
| 12 | knekt2002 | 10.1093/ajcn/76.3.560 | 12198000 | 1 (exists) | HTTP 302 | crossref: "Flavonoid intake and risk of chronic diseases" ✔ |
| 13 | berrin2003 | 10.1042/BJ20021876 | 12667141 | 1 (exists) | HTTP 302 | crossref: "Substrate (aglycone) specificity of human cytosolic beta-glucosidase" ✔ |
| 14 | day2003 | 10.1016/s0006-2952(03)00039-x | 12663055 | 1 (exists) | HTTP 302 | crossref: "Absorption of quercetin-3-glucoside and quercetin-4′-glucoside in the " ✔ |
| 15 | malalavidhane2003 | 10.1002/ptr.1345 | 14595595 | 1 (exists) | HTTP 302 | crossref: "Oral hypoglycaemic activity of Ipomoea aquatica in streptozotocin‐indu" ✔ |
| 16 | nemeth2003 | 10.1007/s00394-003-0397-3 | 12594539 | 1 (exists) | HTTP 302 | crossref: "Deglycosylation by small intestinal epithelial cell ?-glucosidases is " ✔ |
| 17 | hernandez2004 | 10.1207/s15327914nc4902_1 | 15489203 | 1 (exists) | HTTP 302 | crossref: "Reports: Plasma and Dietary Phytoestrogens and Risk of Premalignant Le" ✔ |
| 18 | kroon2004 | 10.1093/ajcn/80.1.15 | 15213022 | 1 (exists) | HTTP 302 | crossref: "How should we assess the effects of exposure to dietary polyphenols in" ✔ |
| 19 | thu2004 | 10.3177/jnsv.50.203 | 15386933 | 1 (exists) | HTTP 302 | crossref: "The Polyphenol Content and Antioxidant Activities of the Main Edible V" ✔ |
| 20 | manach2005 | 10.1093/ajcn/81.1.230S | 15640486 | 1 (exists) | HTTP 302 | crossref: "Bioavailability and bioefficacy of polyphenols in humans. I. Review of" ✔ |
| 21 | prasad2005 | 10.1002/jsfa.2125 | — | 1 (exists) | HTTP 302 | crossref: "Isolation of a free radical‐scavenging antioxidant from water spinach " ✔ |
| 22 | prasad2005b | 10.4103/0253-7613.19079 | — | 1 (exists) | HTTP 302 | crossref: "In vitro cytotoxic properties of Ipomoea aquatica leaf" ✔ |
| 23 | cao2007 | 10.1080/14786410600929576 | 17680496 | 1 (exists) | HTTP 302 | crossref: "Ipomoeassin F, a new cytotoxic macrocyclic glycoresin from the leaves " ✔ |
| 24 | jin2007 | no DOI; https://pubmed.ncbi.nlm.nih.gov/17704030/ | 17704030 | — | HTTP 200 (PubMed page) | PubMed record confirmed via E-utilities ✔ |
| 25 | kottra2007 | 10.1124/jpet.107.124040 | 17495124 | 1 (exists) | HTTP 302 | crossref: "Flavonoid Glycosides Are Not Transported by the Human Na+/Glucose Tran" ✔ |
| 26 | lee2007 | 10.1248/bpb.30.1074 | 17541156 | 1 (exists) | HTTP 302 | crossref: "The Chemopreventive Effect of Taxifolin Is Exerted through ARE-Depende" ✔ |
| 27 | neufert2007 | 10.1038/nprot.2007.279 | 17703211 | 1 (exists) | HTTP 302 | crossref: "An inducible mouse model of colon carcinogenesis for the analysis of s" ✔ |
| 28 | vuong2007 | 10.1111/j.1365-3156.2007.01944.x | 18005318 | 1 (exists) | HTTP 302 | crossref: "Faecal and protozoan parasite contamination of water spinach (Ipomoea " ✔ |
| 29 | bobe2008 | 10.1158/1055-9965.EPI-07-0747 | 18559549 | 1 (exists) | HTTP 302 | crossref: "Dietary Flavonoids and Colorectal Adenoma Recurrence in the Polyp Prev" ✔ |
| 30 | egert2008 | 10.1093/jn/138.9.1615 | 18716159 | 1 (exists) | HTTP 302 | crossref: "Daily Quercetin Supplementation Dose-Dependently Increases Plasma Quer" ✔ |
| 31 | luo2008 | 10.1080/01635580802100851 | 19005980 | 1 (exists) | HTTP 302 | crossref: "Inhibition of Cell Growth and VEGF Expression in Ovarian Cancer Cells " ✔ |
| 32 | marcussen2008 | 10.1007/s10661-007-9817-9 | 17593534 | 1 (exists) | HTTP 302 | crossref: "Element contents and food safety of water spinach (Ipomoea aquatica Fo" ✔ |
| 33 | takachi2008 | 10.1093/aje/kwm263 | 17928402 | 1 (exists) | HTTP 302 | crossref: "Fruit and Vegetable Intake and Risk of Total Cancer and Cardiovascular" ✔ |
| 34 | wang2009 | 10.3945/ajcn.2008.26913 | 19158208 | 1 (exists) | HTTP 302 | crossref: "Dietary intake of selected flavonols, flavones, and flavonoid-rich foo" ✔ |
| 35 | murota2010 | 10.1016/j.abb.2010.06.036 | 20638359 | 1 (exists) | HTTP 302 | crossref: "α-Oligoglucosylation of a sugar moiety enhances the bioavailability of" ✔ |
| 36 | karna2011 | 10.1093/carcin/bgr215 | 21948980 | 1 (exists) | HTTP 302 | crossref: "Polyphenol-rich sweet potato greens extract inhibits proliferation and" ✔ |
| 37 | klein2011 | 10.1001/jama.2011.1437 | 21990298 | 1 (exists) | HTTP 302 | crossref: "Vitamin E and the Risk of Prostate Cancer" ✔ |
| 38 | bjelakovic2012 | 10.1002/14651858.CD007176.pub2 | 22419320 | 1 (exists) | HTTP 302 | crossref: "Antioxidant supplements for prevention of mortality in healthy partici" ✔ |
| 39 | jin2012 | 10.1002/14651858.CD009350.pub2 | 22895989 | 1 (exists) | HTTP 302 | crossref: "Dietary flavonoid for preventing colorectal neoplasms" ✔ |
| 40 | meira2012 | 10.1590/s0102-695x2012005000025 | — | 1 (exists) | HTTP 302 | crossref: "Review of the genus Ipomoea: traditional uses, chemistry and biologica" ✔ |
| 41 | oi2012 | 10.1158/1940-6207.CAPR-11-0397 | 22805054 | 1 (exists) | HTTP 302 | crossref: "Taxifolin Suppresses UV-Induced Skin Carcinogenesis by Targeting EGFR " ✔ |
| 42 | zheng2012 | 10.3892/mmr.2011.726 | 22200874 | 1 (exists) | HTTP 302 | crossref: "Anticancer effect and apoptosis induction by quercetin in the human lu" ✔ |
| 43 | deng2013 | 10.3892/etm.2013.1285 | 24223637 | 1 (exists) | HTTP 302 | crossref: "Effects of quercetin on the proliferation of breast cancer cells and e" ✔ |
| 44 | juszczak2013 | 10.1080/02791072.2013.763570 | 23662334 | 1 (exists) | HTTP 302 | crossref: "Recreational Use of D-Lysergamide from the Seeds of Argyreia Nervosa, " ✔ |
| 45 | akhmetzhanov2014 | 10.48550/arXiv.1408.6052 | — | 1 (exists) | HTTP 302 | datacite: "Mean-field dynamics of tumor growth and control using low-impact chemo" ✔ |
| 46 | fan2014 | 10.1021/np5005246 | 25314138 | 1 (exists) | HTTP 302 | crossref: "Cytotoxic Resin Glycosides from Ipomoea aquatica and Their Effects on " ✔ |
| 47 | cincin2015 | 10.1007/s12253-014-9825-3 | 25096395 | 1 (exists) | HTTP 302 | crossref: "Apoptotic Effects of Quercitrin on DLD-1 Colon Cancer Cell Line" ✔ |
| 48 | manigandan2015 | 10.1016/j.biochi.2015.10.014 | 26482805 | 1 (exists) | HTTP 302 | crossref: "Taxifolin curbs NF-κB-mediated Wnt/β-catenin signaling via up-regulati" ✔ |
| 49 | lawal2016 | 10.1111/jfbc.12303 | — | 1 (exists) | HTTP 302 | crossref: "α-Glucosidase Inhibitory and Antioxidant Activities of DifferentIpomoe" ✔ |
| 50 | yang2016 | 10.3390/molecules21040494 | 27089318 | 1 (exists) | HTTP 302 | crossref: "UHPLC-MS/MS Determination, Pharmacokinetic, and Bioavailability Study " ✔ |
| 51 | aune2017 | 10.1093/ije/dyw319 | 28338764 | 1 (exists) | HTTP 302 | crossref: "Fruit and vegetable intake and the risk of cardiovascular disease, tot" ✔ |
| 52 | grosso2017 | 10.1002/mnfr.201600930 | 27943649 | 1 (exists) | HTTP 302 | crossref: "A comprehensive meta‐analysis on dietary flavonoid and lignan intake a" ✔ |
| 53 | hashemzaei2017 | 10.3892/or.2017.5766 | 28677813 | 1 (exists) | HTTP 302 | crossref: "Anticancer and apoptosis-inducing effects of quercetin in vitro and in" ✔ |
| 54 | hefnygad2018 | 10.1002/pca.2709 | 28776774 | 1 (exists) | HTTP 302 | crossref: "Identification of some Bioactive Metabolites in a Fractionated Methano" ✔ |
| 55 | bondonno2019 | 10.1038/s41467-019-11622-x | 31409784 | 1 (exists) | HTTP 302 | crossref: "Flavonoid intake is associated with lower mortality in the Danish Diet" ✔ |
| 56 | sunil2019 | 10.1016/j.phytochem.2019.112066 | 31325613 | 1 (exists) | HTTP 302 | crossref: "An insight into the health-promoting effects of taxifolin (dihydroquer" ✔ |
| 57 | hisaka2020 | 10.21873/anticanres.14469 | 32727794 | 1 (exists) | HTTP 302 | crossref: "Quercetin Suppresses Proliferation of Liver Cancer Cell Lines In Vitro" ✔ |
| 58 | perciedusert2020 | 10.1371/journal.pbio.3000410 | 32663219 | 1 (exists) | HTTP 302 | crossref: "The ARRIVE guidelines 2.0: Updated guidelines for reporting animal res" ✔ |
| 59 | shi2020 | 10.1111/jphp.13282 | 32346882 | 1 (exists) | HTTP 302 | crossref: "Pharmacokinetic, bioavailability and tissue distribution study of asti" ✔ |
| 60 | wang2020 | 10.21037/atm-20-3329 | 32566617 | 1 (exists) | HTTP 302 | crossref: "The anti-tumor effect of taxifolin on lung cancer via suppressing stem" ✔ |
| 61 | hsieh2021 | 10.1017/jns.2021.8 | 33889398 | 1 (exists) | HTTP 302 | crossref: "Association between dietary flavonoid intakes and C-reactive protein l" ✔ |
| 62 | papadimitriou2021 | 10.1038/s41467-021-24861-8 | 34321471 | 1 (exists) | HTTP 302 | crossref: "An umbrella review of the evidence associating diet and cancer risk at" ✔ |
| 63 | thang2021 | 10.1007/s11356-021-14808-3 | 34120286 | 1 (exists) | HTTP 302 | crossref: "Potential health risks of toxic heavy metals and nitrate via commonly " ✔ |
| 64 | sasikala2022 | 10.31557/APJCP.2022.23.11.3657 | 36444577 | 1 (exists) | HTTP 302 | crossref: "Evaluation of the Role of Merromoside from Ipomoea aquatica Forsskal H" ✔ |
| 65 | toy2022 | 10.1016/j.foodres.2022.111552 | 35940778 | 1 (exists) | HTTP 302 | crossref: "Resin glycoside extracts from Ipomoea aquatica retard lipid digestibil" ✔ |
| 66 | saikia2023 | 10.3389/fnut.2023.1304903 | 38192648 | 1 (exists) | HTTP 302 | crossref: "Chemical and biochemical characterization of Ipomoea aquatica: genopro" ✔ |
| 67 | ramos2024 | 10.1016/j.biopha.2024.117276 | 39146763 | 1 (exists) | HTTP 302 | crossref: "Effect of quercetin and chrysin and its association on viability and c" ✔ |
| 68 | wei2024 | 10.1038/s41598-024-79650-2 | 39572657 | 1 (exists) | HTTP 302 | crossref: "The association between fruit and vegetable intake and gastrointestina" ✔ |
| 69 | parmenter2025 | 10.1038/s43016-025-01176-1 | 40456886 | 1 (exists) | HTTP 302 | crossref: "High diversity of dietary flavonoid intake is associated with a lower " ✔ |
| 70 | huang2026 | 10.1016/j.fochx.2026.104332 | 42699119 | 1 (exists) | HTTP 302 | crossref: "Chemical profiling of vegetable polyphenols reveals matrix-dependent i" ✔ |
| 71 | wu2026 | 10.1016/j.ecoenv.2026.120604 | 42570584 | 1 (exists) | HTTP 302 | crossref: "From raw to cooked: The impact of cooking on bioaccessibility and heal" ✔ |

No bibliography entry carries a retraction, withdrawal or expression of concern (Crossref `updated-by` and PubMed publication types). The two Cochrane reviews (Bjelakovic 2012, Jin 2012) carry only "new version" notices; they are cited as the versions named.

**Manual corrections to registry metadata:** Göthberg 2002 DOI set to 10.1002/etc.5620210922 (checked at the resolver); Prasad 2005b author order corrected to Prasad, Ashok, Raghu, Shivamurthy, Vijayan, Aradhya, as printed. Jin 2007 (*Nutr Cancer*) and Kasturi 1998 (*Clin Cancer Res*) have no DOI registered (Crossref search) and are linked by PubMed URL.

## 3. Thread claims checked against sources

- **Key compound isolation paper: found.** Prasad KN, Divakar S, Shivamurthy GR, Aradhya SM (2005) *J Sci Food Agric* 85:1461-1468, doi:10.1002/jsfa.2125. **Discrepancy:** the paper names the compound *7-O-β-D-glucopyranosyl-dihydroquercetin-3-O-α-D-glucopyranoside* (α at C-3) and calls the identification *tentative*. The review quoted in the thread, and therefore the thread itself, used β at C-3. Antioxidant EC50 values are 83 and 72.2 µg/mL.
- **The 2005 cytotoxicity ("CTC50") figures: traced.** Meira et al. 2012 (*Rev Bras Farmacogn*, doi:10.1590/s0102-695x2012005000025) reports CTC50 values for the purified diglucoside of 387 (Vero, normal), 156 (HEp-2) and 394 (A-549) "mg/mL". For the crude extract and its column fraction it reports 41–332, 46–114 and 44–230 mg/mL. It cites Prasad et al. 2005b (*Indian J Pharmacol*, doi:10.4103/0253-7613.19079). Grok's "40–400 mg/ml" fairly summarises these ranges. The paper treats "mg/mL" as a probable transcription of µg/mL (387 mg/mL would be about 40% w/v) and converts using MW ≈ 628 g/mol (≈250–630 µM), labelling the assumption. The Prasad 2005b full text was not retrieved.
- **4-ipomeanol human trial: verified.** Kasturi VK et al. 1998, *Clin Cancer Res* 4:2095-102, PMID 9748125. Hepatotoxicity was dose-limiting and there were no objective responses.
- **LPH/CBG and other mammals: partly verified.** Human LPH and CBG: Day 1998, Németh 2003. Sheep LPH: Day 2000. Rat LPH-dependent absorption: Day 2003. Human intestinal SGLT1 does not carry quercetin glucosides: Kottra & Daniel 2007. Pig and dog enzymes were **not** separately sourced and are not claimed.
- **α-glucoside cleavage:** no source was found testing human LPH/CBG on a 3-O-α-glucosyl flavonoid. The paper marks this step [Proposed] (M3) and makes it the first experiment.
- **Polymerisation (thread question):** no primary source was found. Grok's answer is not relied on.

## 4. Dropped or excluded

- **Razak S et al. 2018, *BMC Cancer* 18:1043 (taxifolin, colorectal), doi:10.1186/s12885-018-4959-4, PMID 30367624.** **RETRACTED** (notice *BMC Cancer* 2025;25:1598, doi:10.1186/s12885-025-15080-1). Excluded.
- Grok list items without PMIDs (quercetin on LNCaP/DU-145/PC-3; DHQ on SK-OV-3; taxifolin on MDA-MB-231/4T1; taxifolin on AGS): not located or verified; excluded.
- Verified but dropped to keep the list focused (all DOIs resolved; none retracted): Prasad, Shivamurthy & Aradhya 2008 *Int J Bot* review (doi:10.3923/ijb.2008.123.129; full text behind a bot check; superseded as the CTC50 source by Meira 2012); Catalano 2016; Hefny Gad 2021; Fu 2011; Gee 2000; Ratnatilaka 2010; Seow 2002.
- arXiv: of the manifest PDFs, only 1408.6052 (Akhmetzhanov 2014) is cited, labelled "not peer reviewed", for framing only. The rest were off-topic or computational only.
- Grok chart image (grok-morning-glory-chart.jpg): not reused (the moonflower panel shows a daisy); replaced by Table 2.
