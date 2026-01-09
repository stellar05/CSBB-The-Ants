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
