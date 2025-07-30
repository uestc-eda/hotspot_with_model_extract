# HotSpot with Thermal Model Extraction

HotSpot with Thermal Model Extraction is a tool that extracts thermal model matrices from HotSpot. Such extracted matrices G, C, B, L, A, A\_bar can be used in other tools or simulators. 

See [here](https://wanghaiuestc.github.io) for more opensource softwares from my group. 

## Installation

### 1. Install superlu, if not installed

For Linux (Ubuntu):

```sh
sudo apt-get install libsuperlu-dev
```

For MacOS (both Intel and applesilicon):

```sh
brew install superlu
```

### 2. Install HotSpot

In the path of ```hotspot_with_model_extract```, run:

```sh
make
```

## Thermal Model Extraction

### 1. Run HotSpot

Run HotSpot with the option of your desired thermal model configurations, just like with normal HotSpot. For example, in the path of ```hotspot_with_model_extract```, run:

```sh
./hotspot -c DDR_16core/cores_hotspot.config -p power_core.trace -o temperature_core.trace -model_secondary 1 -model_type grid -steady_state_print_disable 1 -type DDR -sampling_intvl 0.001 -grid_layer_file DDR_16core/cores.lcf -detailed_3D on
```

Now, in the folder ```hotspot_with_model_extract/model_extract```,
you should see the new files generated for G matrix (three files in
sparse format): Amatrixnzval, Amatrixcolptr, Amatrixrowind; file for C
matrix: Cmatrix (diagonal elements); file for B matrix: Bmatrix (row,
col, val); file for L matrix: Lmatrix (row, col, val).

The difference between Bmatrix and Lmatrix: Bmatrix only
contains the mapping information of layers with power (defined in
*.lcf file). Lmatrix contains the mapping information of all layers,
including the ones without power. 

### 2. Run Matlab script

In Matlab command window, go to the path ```hotspot_with_model_extract/model_extract```, run

```sh
model_extract
```

Now, in the folder ```hotspot_with_model_extract/model_extract```,
you should see the newly generated G, C, B, L files: G.mat, C.mat, B.mat, L.mat. There are also two new files generated for tools like GDP: A.mat, A\_xxms.mat. Here A.mat is the A matrix and A\_xxms.mat (default is A\_1ms.mat) is the A\_bar matrix in the GDP paper.