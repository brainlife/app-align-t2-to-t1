<h1 align="center">Align T2 to T1 using FSL FLIRT</h1>

<p align="center">
  A T2-weighted image aligned to, and resampled into the space of, an ACPC-aligned T1-weighted image.
</p>

<p align="center">
  <a href="https://github.com/brainlife/abcd-spec"><img src="https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg" alt="ABCD Spec v1.1"></a>
  <a href="https://doi.org/10.25663/brainlife.app.510"><img src="https://img.shields.io/badge/Brainlife-brainlife.app.510-blue.svg" alt="Run on brainlife.io"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-lightgrey.svg" alt="MIT license"></a>
</p>

## At a glance

<!-- brainlife-app:begin (generated from the App manifest; edit the manifest, not this block) -->

> **Aligns a T2-weighted image to an ACPC-aligned T1-weighted image with FSL flirt (brain-extracted registration), producing a T2w image in T1w space.**

Optionally crops the T2w image with robustfov, brain-extracts both images with bet, estimates a flirt transform from the T2w brain to the T1w brain with the chosen degrees of freedom and cost function, and applies it to the whole T2w image on the T1w grid. Use it so T2w data can be used alongside the T1w image (for example in FreeSurfer or myelin mapping).

| | |
|---|---|
| **Inputs** | `neuro/anat/t1w` · `neuro/anat/t2w` |
| **Outputs** | `neuro/anat/t2w` |
| **Container** | `brainlife/fsl:5.0.11` |
| **Resources** | 1 CPUs · 12 GB memory · 0.75 h walltime |
| **Run it** | [doi.org/10.25663/brainlife.app.510](https://doi.org/10.25663/brainlife.app.510) |

#### Inputs

| Input | Datatype | Required | Description |
|---|---|---|---|
| `t1` | `neuro/anat/t1w` (acpc_aligned) | yes | reference t1 to align t2 data to |
| `t2` | `neuro/anat/t2w` | yes | t2 data to align |

#### Outputs

| Output | Datatype | Description |
|---|---|---|
| `output` | `neuro/anat/t2w` | T2-weighted image resampled into the ACPC-aligned T1w space. |

<details>
<summary><b>Parameters</b> (3)</summary>

| Parameter | Type | Default | Description |
|---|---|---|---|
| `crop` | boolean | `false` | If true, will crop using fsl robustfov. if false, will not. default == false |
| `cost` | enum | `mutualinfo` | Cost function used by flirt to estimate the T2-to-T1 transform (mutual information by default). Options: `mutualinfo`, `corratio`, `normcorr`, `normmi`, `leastsq`, `labeldiff`, `bbr`. |
| `dof` | number | `12` | Degrees of freedom of the flirt transform (for example 6 rigid, 12 affine). |

</details>

<!-- brainlife-app:end -->

## Running the App

### On brainlife.io

Open the App at [doi.org/10.25663/brainlife.app.510](https://doi.org/10.25663/brainlife.app.510), choose an ACPC-aligned T1-weighted dataset (the reference) and the T2-weighted dataset to align, set the options and press **Execute**. The result is a `neuro/anat/t2w` dataset tagged `acpc_aligned`, archived to your project, so T2-weighted data can be used alongside the T1-weighted image (for example in FreeSurfer or myelin mapping).

The App:

1. optionally crops the T2-weighted image with `robustfov` (`crop`);
2. brain-extracts both images with `bet`;
3. estimates a FLIRT transform from the T2w brain to the T1w brain with the chosen degrees of freedom (`dof`, default 12) and cost function (`cost`, default `mutualinfo`);
4. applies the transform to the whole T2-weighted image on the T1-weighted grid.

### Locally

You need [Singularity/Apptainer](https://apptainer.org/) and [`jq`](https://jqlang.github.io/jq/). FSL runs inside the container.

1. Clone this repository and check out the branch brainlife.io runs: `git checkout v1.0` (FSL 5.0.11; `master` uses FSL 6.0.4).
2. Create `config.json` with the paths to your inputs and the options you want:

   ```json
   {
       "t1": "/input/t1/t1.nii.gz",
       "t2": "/input/t2/t2.nii.gz",
       "crop": false,
       "cost": "mutualinfo",
       "dof": 12
   }
   ```

   `cost` is one of `mutualinfo`, `corratio`, `normcorr`, `normmi`, `leastsq`, `labeldiff` or `bbr`.

3. Run the App:

   ```bash
   ./main
   ```

### Sample data

Download sample datasets from brainlife.io with the [brainlife CLI](https://github.com/brainlife/cli):

```bash
npm install -g brainlife
bl login
mkdir input
bl dataset download <dataset-id>
```

## Outputs

```text
output/
└── t2.nii.gz   T2-weighted image resampled into the ACPC-aligned T1w space
```

## Troubleshooting

- **`something went wrong. check derivatives`**: FLIRT did not write `output/t2.nii.gz`. Check the log; try `crop: true` for images with a large field of view, or another cost function.

## Citing

> [!TIP]
> If you use this App in your work, please cite the App, the software it builds on and brainlife.io (below). GitHub's **Cite this repository** button gives the App citation in APA and BibTeX.

- Woolrich MW, Jbabdi S, Patenaude B, Chappell M, Makni S, Behrens T, Beckmann C, Jenkinson M, Smith SM. Bayesian analysis of neuroimaging data in FSL. *NeuroImage* 45:S173–186 (2009).
- Smith SM, Jenkinson M, Woolrich MW, Beckmann CF, Behrens TEJ, Johansen-Berg H, Bannister PR, De Luca M, Drobnjak I, Flitney DE, Niazy R, Saunders J, Vickers J, Zhang Y, De Stefano N, Brady JM, Matthews PM. Advances in functional and structural MR image analysis and implementation as FSL. *NeuroImage* 23(S1):208–219 (2004).
- Jenkinson M, Beckmann CF, Behrens TE, Woolrich MW, Smith SM. FSL. *NeuroImage* 62:782–790 (2012).
- Align T2  to T1 using FSL Flirt. brainlife.io App. [doi:10.25663/brainlife.app.510](https://doi.org/10.25663/brainlife.app.510)
- Fischl. FreeSurfer. *NeuroImage* 62:774-781 (2012). [doi:10.1016/j.neuroimage.2012.01.021](https://doi.org/10.1016/j.neuroimage.2012.01.021)
- Jenkinson et al. FSL. *NeuroImage* 62:782-790 (2012). [doi:10.1016/j.neuroimage.2011.09.015](https://doi.org/10.1016/j.neuroimage.2011.09.015)
- Hayashi S, Caron BA, Heinsfeld AS, et al. brainlife.io: a decentralized and open-source cloud platform to support neuroscience research. *Nature Methods* 21:809–813 (2024). [doi:10.1038/s41592-024-02237-2](https://doi.org/10.1038/s41592-024-02237-2)
- Avesani P, McPherson B, Hayashi S, et al. The open diffusion data derivatives, brain data upcycling via integrated publishing of derivatives and reproducible open cloud services. *Scientific Data* 6:69 (2019). [doi:10.1038/s41597-019-0073-y](https://doi.org/10.1038/s41597-019-0073-y)

## Authors

- Franco Pestilli (project director)
- Brad Caron

**Contributors:** Soichi Hayashi

## Funding

[![Wellcome-226486/Z/22/Z](https://img.shields.io/badge/Wellcome-226486%2FZ%2F22%2FZ-purple.svg)](https://wellcome.org/)
[![NIH-NINDS-U24NS140384](https://img.shields.io/badge/NIH_NINDS-U24NS140384-green.svg)](https://reporter.nih.gov/project-details/11261037)
[![NIH-NINDS-UM1NS132207](https://img.shields.io/badge/NIH_NINDS-UM1NS132207-green.svg)](https://reporter.nih.gov/project-details/11411328)
[![NIH-NIBIB-R01EB029272](https://img.shields.io/badge/NIH_NIBIB-R01EB029272-green.svg)](https://reporter.nih.gov/project-details/10262925)
[![NIH-NIBIB-R01EB030896](https://img.shields.io/badge/NIH_NIBIB-R01EB030896-green.svg)](https://reporter.nih.gov/project-details/10428625)
[![NIH-NIMH-R01MH126699](https://img.shields.io/badge/NIH_NIMH-R01MH126699-green.svg)](https://reporter.nih.gov/project-details/10460628)
[![NIH-NIDCD-R01DC020088](https://img.shields.io/badge/NIH_NIDCD-R01DC020088-green.svg)](https://reporter.nih.gov/project-details/11140284)
[![NSF-BCS-1734853](https://img.shields.io/badge/NSF_BCS-1734853-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1734853)
[![NSF-BCS-2203524](https://img.shields.io/badge/NSF_BCS-2203524-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2203524)
[![NSF-IIS-1636893](https://img.shields.io/badge/NSF_IIS-1636893-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1636893)
[![NSF-OAC-2148729](https://img.shields.io/badge/NSF_OAC-2148729-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2148729)
[![NSF-IIS-1912270](https://img.shields.io/badge/NSF_IIS-1912270-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1912270)
[![NSF-IIS-2148700](https://img.shields.io/badge/NSF_IIS-2148700-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2148700)
[![NSF-OAC-1916518](https://img.shields.io/badge/NSF_OAC-1916518-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1916518)

<sub>brainlife.io is publicly funded, and acknowledging that support helps keep it running. This App was developed with support from Wellcome, the U.S. National Institutes of Health (including the BRAIN Initiative BRAIN CONNECTS program: The Axonal Projectome EXchange, U24NS140384, and the Center for Mesoscale Connectomics, UM1NS132207) and the U.S. National Science Foundation.</sub>

## License

[MIT](LICENSE). FSL itself is distributed under its own [license](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/Licence).
