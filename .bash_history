exit
curl -s https://raw.githubusercontent.com/linuxautomations/scripts/master/init.sh | sudo bash
python --version
curl -O https://bootstrap.pypa.io/get-pip.py
python get-pip.py --user
ls -a ~
export PATH=~/.local/bin:$PATH
source ~/.bash_profile
pip3 --version
pip2 --version
pip --version
pip install awscli --upgrade --user
aws --version
