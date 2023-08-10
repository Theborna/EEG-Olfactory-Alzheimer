# Analysis of Phase Locking Value during Olfactory Stimulation as a Biomarker for Alzheimer's Disease in EEG Signals

## Introduction

This project aimed to identify early biomarkers for neurodegenerative diseases like Alzheimer's disease (AD) and mild cognitive impairment (MCI) by analyzing electroencephalography (EEG) signals during olfactory stimulation.

Olfactory dysfunction is one of the earliest symptoms of AD and MCI. The goal was to analyze the phase locking value (PLV) and other phase-amplitude coupling (PAC) metrics of EEG signals between different brain regions during odor stimulation as potential biomarkers to differentiate AD, MCI and normal subjects.

## Methodology

- EEG data was collected from AD, MCI and normal subjects during a controlled experiment with frequent and rare odors.

- The data was preprocessed using standard EEG pipelines in EEGLAB. 

- PLV was calculated between channels like Fz and Cz to quantify phase synchronization.

- PLV was also computed for MCI subjects and compared across groups.

- Other PAC metrics like modulation index were implemented and evaluated.

- Statistical tests compared the metrics between groups and conditions.

## Results

- Rare trials PLV was significantly different between AD and normal (p = 0.037). 

- Frequent trials PLV difference was not significant between AD and normal (p = 0.156).

- Potential PLV differences found between AD-MCI and normal-MCI groups.

- Fz and Cz had the most distinct PLV patterns between groups.

- Phase histograms showed more sparse patterns in AD compared to normal subjects.

- Modulation index did not show significant differences between groups.

## Conclusion

The PLV analysis indicates it could be a useful biomarker to differentiate AD and normal subjects based on EEG olfactory data. However, more research is needed to further validate the findings given limitations like small sample sizes. The modulation index did not reveal significant patterns, suggesting PLV may be more relevant for the specific stimuli used. Future work should investigate larger datasets across AD, MCI and normal groups and explore other PAC metrics.

## References

Refer to `report.pdf` or `refs.bib` in the `report` directory for complete list of cited references.


## Code

MATLAB code for preprocessing, PLV computation etc is in `computation` directory.
