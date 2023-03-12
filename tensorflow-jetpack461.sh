# Check if user is not root
if [ "$EUID" -ne 0 ]
    then echo "Please run this script as root."
    exit
fi

export JP_VERSION=461
export $TF_VERSION
export $NV_VERSION

# Installing tensorflow
# Documentation: https://docs.nvidia.com/deeplearning/frameworks/install-tf-jetson-platform/index.html
# Archive: https://web.archive.org/web/20220524164254/https://docs.nvidia.com/deeplearning/frameworks/install-tf-jetson-platform/index.html

# Install required packages for tensorflow
apt-get update
apt-get install libhdf5-serial-dev hdf5-tools libhdf5-dev zlib1g-dev zip libjpeg8-dev liblapack-dev libblas-dev gfortran

# Install python3-pip
apt-get update
apt-get install python3-pip

# Install and upgrade pip3
pip3 install -U pip testresources setuptools==49.6.0

# Install the Python package dependencies
pip3 install -U --no-deps numpy==1.19.4 future==0.18.2 mock==3.0.5 keras_preprocessing==1.1.2 keras_applications==1.0.8 gast==0.4.0 protobuf==3.13.0 pybind11==2.10.0 cython==0.29.32 pkgconfig==1.5.5
export H5PY_SETUP_REQUIRES=0
pip3 install -U h5py==3.1.0

# Install tensorflow
pip3 install --pre --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v$JP_VERSION tensorflow

# Run python3
# Expected to print nothing, else something's wrong
python3 -c "import tensorflow;"
