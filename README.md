[![Abcdspec-compliant](https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg)](https://github.com/brain-life/abcd-spec)
[![Run on Brainlife.io](https://img.shields.io/badge/Brainlife-brainlife.app.510-blue.svg)](https://doi.org/https://doi.org/10.25663/brainlife.app.510)

# Align T2 to T1 using FSL Flirt

<!-- brainlife-app:begin (generated from the App manifest; edit the manifest, not this block) -->

**Aligns a T2-weighted image to an ACPC-aligned T1-weighted image with FSL flirt (brain-extracted registration), producing a T2w image in T1w space.**

Optionally crops the T2w image with robustfov, brain-extracts both images with bet, estimates a flirt transform from the T2w brain to the T1w brain with the chosen degrees of freedom and cost function, and applies it to the whole T2w image on the T1w grid. Use it so T2w data can be used alongside the T1w image (for example in FreeSurfer or myelin mapping).

Run it on brainlife.io: [https://doi.org/10.25663/brainlife.app.510](https://doi.org/10.25663/brainlife.app.510)

| Input | Datatype | Required | Description |
|---|---|---|---|
| `t1` | `neuro/anat/t1w` (acpc_aligned) | yes | reference t1 to align t2 data to |
| `t2` | `neuro/anat/t2w` | yes | t2 data to align |

| Output | Datatype | Description |
|---|---|---|
| `output` | `neuro/anat/t2w` | T2-weighted image resampled into the ACPC-aligned T1w space. |

| Parameter | Type | Default | Description |
|---|---|---|---|
| `crop` | boolean | `false` | If true, will crop using fsl robustfov. if false, will not. default == false |
| `cost` | enum | `mutualinfo` | Cost function used by flirt to estimate the T2-to-T1 transform (mutual information by default). Options: `mutualinfo`, `corratio`, `normcorr`, `normmi`, `leastsq`, `labeldiff`, `bbr`. |
| `dof` | number | `12` | Degrees of freedom of the flirt transform (for example 6 rigid, 12 affine). |

Runtime: container `brainlife/fsl:5.0.11`; 1 CPUs; 12 GB memory; 0.75 h walltime.

<!-- brainlife-app:end -->

This app will This app will align anatomical t2w data to an anatomical t1w image using FSL's flirt command. This is done to ensure that t2w data is in same space as anatomical t1w image, which is used for most analyses.

### Authors

- Brad Caron (bacaron@utexas.edu)

### Contributors

- Soichi Hayashi (shayashi@iu.edu)

### Funding Acknowledgement

brainlife.io is publicly funded and for the sustainability of the project it is helpful to Acknowledge the use of the platform. We kindly ask that you acknowledge the funding below in your publications and code reusing this code.

[![NSF-BCS-1734853](https://img.shields.io/badge/NSF_BCS-1734853-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1734853)
[![NSF-BCS-1636893](https://img.shields.io/badge/NSF_BCS-1636893-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1636893)
[![NSF-ACI-1916518](https://img.shields.io/badge/NSF_ACI-1916518-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1916518)
[![NSF-IIS-1912270](https://img.shields.io/badge/NSF_IIS-1912270-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1912270)
[![NIH-NIBIB-R01EB029272](https://img.shields.io/badge/NIH_NIBIB-R01EB029272-green.svg)](https://grantome.com/grant/NIH/R01-EB029272-01)

### Citations

We kindly ask that you cite the following articles when publishing papers and code using this code.

1. Avesani, P., McPherson, B., Hayashi, S. et al. The open diffusion data derivatives, brain data upcycling via integrated publishing of derivatives and reproducible open cloud services. Sci Data 6, 69 (2019). https://doi.org/10.1038/s41597-019-0073-y

2. M.W. Woolrich, S. Jbabdi, B. Patenaude, M. Chappell, S. Makni, T. Behrens, C. Beckmann, M. Jenkinson, S.M. Smith. Bayesian analysis of neuroimaging data in FSL. NeuroImage, 45:S173-86, 2009

3. S.M. Smith, M. Jenkinson, M.W. Woolrich, C.F. Beckmann, T.E.J. Behrens, H. Johansen-Berg, P.R. Bannister, M. De Luca, I. Drobnjak, D.E. Flitney, R. Niazy, J. Saunders, J. Vickers, Y. Zhang, N. De Stefano, J.M. Brady, and P.M. Matthews. Advances in functional and structural MR image analysis and implementation as FSL. NeuroImage, 23(S1):208-19, 2004

4. M. Jenkinson, C.F. Beckmann, T.E. Behrens, M.W. Woolrich, S.M. Smith. FSL. NeuroImage, 62:782-90, 2012

#### MIT Copyright (c) 2020 brainlife.io The University of Texas at Austin and Indiana University

## Running the App

### On Brainlife.io

You can submit this App online at [https://doi.org/https://doi.org/10.25663/brainlife.app.510](https://doi.org/https://doi.org/10.25663/brainlife.app.510) via the 'Execute' tab.

### Running Locally (on your machine)

1. git clone this repo

2. Inside the cloned directory, create `config.json` with something like the following content with paths to your input files.

```json
{
	"t1": "/input/t1/t1.nii.gz",
	"t2": "/input/t2/t2.nii.gz",
	"crop": true,
	"cost": "mutualinfo",
	"dof": 12
}
```

### Sample Datasets

You can download sample datasets from Brainlife using [Brainlife CLI](https://github.com/brain-life/cli).

```
npm install -g brainlife
bl login
mkdir input
bl dataset download
```

3. Launch the App by executing 'main'

```bash
./main
```

## Output 

The main output of this App is an anat/t2w datatype.

#### Product.json

The secondary output of this app is `product.json`. This file allows web interfaces, DB and API calls on the results of the processing.

### Dependencies

This App only requires [singularity](https://www.sylabs.io/singularity/) to run. If you don't have singularity, you will need to install following dependencies.   

- FSL: https://fsl.fmrib.ox.ac.uk/fsl/fslwiki

#### MIT Copyright (c) 2020 brainlife.io The University of Texas at Austin and Indiana University
