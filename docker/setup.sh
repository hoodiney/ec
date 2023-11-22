# eval `opam config env`
# if [ $# = 0 ] ; then exec bash; else exec "$@"; fi
DEBIAN_FRONTEND=noninteractive apt-get update && apt-get -y install tzdata
apt-get -y install python3 git wget opam m4 libcairo2-dev libzmq3-dev swig graphviz sudo

mkdir /container
chmod 777 /container
HOME=/container
export HOME

wget https://repo.continuum.io/miniconda/Miniconda3-py37_4.9.2-Linux-x86_64.sh
chmod +x Miniconda3-py37_4.9.2-Linux-x86_64.sh
./Miniconda3-py37_4.9.2-Linux-x86_64.sh -b  -p /usr/local/conda
rm ./Miniconda3-py37_4.9.2-Linux-x86_64.sh
export PATH="/usr/local/conda/bin:$PATH"

conda install -y  numpy dill pyzmq matplotlib protobuf scikit-learn scipy #vose-alias-method
pip install git+https://github.com/MaxHalford/vose@fae179e5afa45f224204519c10957d087633ae60
pip install dill sexpdata pygame pycairo cairocffi psutil pypng Box2D-kengz graphviz frozendict pathos

conda install pytorch==1.2.0 torchvision==0.4.0 cpuonly -c pytorch

wget https://downloads.python.org/pypy/pypy3.6-v7.3.3-linux64.tar.bz2
tar xjvf pypy3.6-v7.3.3-linux64.tar.bz2
rm pypy3.6-v7.3.3-linux64.tar.bz2
mv pypy3.6-v7.3.3-linux64 /container
PATH=/container/pypy3.6-v7.3.3-linux64/bin:$PATH

pypy3 -m ensurepip
pypy3 -m pip install vmprof
pypy3 -m pip install dill
pypy3 -m pip install psutil
pypy3 -m pip install frozendict
pypy3 -m pip install numpy
pypy3 -m pip install pathos

cd /container
git clone https://github.com/hoodiney/ec.git
cd ec
sed -i "s|url = git@github.com:insperatum/pregex.git|url = https://github.com/insperatum/pregex.git|" .gitmodules
sed -i "s|url = git@github.com:insperatum/pinn.git|url = https://github.com/insperatum/pinn.git|" .gitmodules
git submodule update --recursive --init
cd /
