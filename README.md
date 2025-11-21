# CSBB-The-Ants

Welcome to the data and code repository for The Ants CSBB team. 

## Repository Structure

- The training dataset is saved in the directory `data`.
- The images of the H&E stained lymph node slices are saved in the directory `tiff_files`.
- Code related to the ML pipeline can be found in the directory `src` in a jupyter notebook.

## ML Pipeline for H&E stained Lymph Node Images

This repo contains a simple machine learning model trained Using images from the [PCam](https://github.com/basveeling/pcam) dataset. This model was used to extract areas of interest to image from patient lymph node slides.

### Installation

It is recommended to use a package manager such as Anaconda or [venv](https://docs.python.org/3/library/venv.html) when running the project. To create, activate, and install the requirements in a python virtual environment run the following commands in the terminal: 

**MacOS/Linux**
```
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```
**Windows**
```
python -m venv .venv
.venv/Scripts/activate
pip install -r requirements.txt
```

### Contributing

This project uses [Ruff](https://docs.astral.sh/ruff/) to format and lint code. In order to format code, run `ruff format`. To check codestyle, run `ruff check` or `ruff check --fix` to fix any fixable errors.

### Running the Pipeline

Follow the instructions in the `pipeline.ipynb` jupyter notebook to train the machine learning model and run the entire pipeline.

<!-- The training data images and labels are in the `data` folder, where `camelyonpatch_split_training_x.h5` contains image data and `camelyonpatch_split_training_y.h5` contains the corresponding labels. 

The pipeline can be run by running the `training.py` file with the following arguments:

- `--h5-img`: Path to the .h5 image data
- `--h5-label`: Path to the .h5 label data
- `--output-dir`: Optional path to save the best results
- `--batch-size`: Optional batch size, default is 64
- `--epochs`: Optional number of epochs of training, default is 30
- `--lr`: Optional learning rate, default is 1e-4
- `--val-frac`: Optional fraction of data to use for validation, default 0.2
- `--img-size`: Optional image size, default is 96
- `--num-workers`: Optional number of workers, default is 4
- `--seed`: Optional seed to use, default 42

For example, from the root directory running the model with batch size 100 and 5 epochs can be done with the following command:

```bash
python ./src/training.py --h5-img ./data/camelyonpatch_split_training_x.h5 --h5-label ./data/camelyonpatch_split_training_y.h5 --batch-size 100 --epochs 5
```

The best result will be saved in `results/best.pth` (unless otherwise specified with `--output-dir`).

### Running the Trained Model on New Data

Running the best trained model on new input data can be done using `predict.py` with the following arguments:

- `--tiff-dir`: specify the path to the directory containing the `.tif` or `.tiff` files.
- `--model-path`: specify the path to the best model (by default saved in `results/best.pth`)
- `--output-dir`: Optional, specify the path to save results to, default `results/tiff_preds`
- `--output-csv`: Optional, specify filename for the per-patch output file
- `--agg-csv`: Optional, specify filename for the aggregated output scores file
- `--patch-size`: Optional, specify the size of patches to subdivide the files into, default is 96
- `--stride`: Optional, specify the stride between patches to allow for overlap, default is no overlap
- `--pad-edges`: Optional, specify whether edges should be padded to fit subdivisions
- `--batch-size`: Optional, specify batch size, default is 64
- `--num-workers`: Optional number of workers, default is 4
- `--threshold`: Optional threshold probability at which the model classifies to 1, default is 0.5

### Visualizing Results

There are two ways to visualize the results of the model. The first way is using `visualize_outline.py`, where areas of interest are outlined in red. The second way is `visualize_heatmap.py`, where a heatmap is overlayed on the image depending on the probability computed by the model. -->