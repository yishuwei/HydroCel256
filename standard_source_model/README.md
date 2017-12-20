# standard_source_model

aligned_ftstruct257.mat : 257 sensors with coordinates aligned to FieldTrip standard head model

Use this to calculate lead field, etc.

cf. http://www.fieldtriptoolbox.org/template/headmodel



Technical Notes
------

align_electrodes.m is the script used to align the electrodes. Alignment is based on simple 
affine transformation. The aligned electrode positions are not exactly on the scalp. The 
FieldTrip routine `ft_prepare_vol_sens` can be used to project all electrodes onto the scalp 
(which is called internally by `ft_prepare_leadfield`). However, be sure to first exclude the 
lower electrodes before such projection when using the FieldTrip template head model as the 
skin surface does not cover the lower part of the head.

For a more academic description of the alignment method, please see the following article, 
section **Source Reconstruction of Between-Group HEP Differences**.

Wei et al. I keep a close watch on this heart of mine: Increased interoception in insomnia. 
SLEEP 39 (2016). DOI: [10.5665/sleep.6308][HEPPaper]

[HEPPaper]: https://doi.org/10.5665/sleep.6308
