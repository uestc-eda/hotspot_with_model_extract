# HotSpot with Thermal Model Extraction

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

## Thermal Model Extraction example


```sh
./hotspot -c DDR_16core/cores_hotspot.config -p power_core.trace -o temperature_core.trace -model_secondary 1 -model_type grid -steady_state_print_disable 1 -type DDR -sampling_intvl 0.001 -grid_layer_file DDR_16core/cores.lcf -detailed_3D on
```

You should see the new files generated for G matrix (three files in
sparse format): Amatrixnzval, Amatrixcolptr, Amatrixrowind; file for C
matrix: Cmatrix (diagonal elements); file for B matrix: Bmatrix (row,
col, val); file for L matrix: Lmatrix (row, col, val).

The difference between Bmatrix and Lmatrix: Bmatrix only
contains the mapping information of layers with power (defined in
*.lcf file). Lmatrix contains the mapping information of all layers,
including ones without power. 
