#|/bin/sh

# This requires root privilege. Assumes nothing about the target platform (except being a GNU/Linux Debian-compatible distribution).
# Install ReSeQC
# Author: Hernan Morales Durand <hernan.morales@gmail.com>

apt-get install python-setuptools python-dev python-lzo liblz4-dev
python get-pip.py
pip install --index-url=https://pypi.python.org/simple/ RSeQC
