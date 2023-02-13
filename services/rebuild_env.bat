python3.10 -m venv ./venv --upgrade-deps
source ./venv/bin/activate
pip install wheel
pip install --use-deprecated=legacy-resolver -r requirements.txt

set +e

for SERVICE in "notification" "socket" "tools"; do
    cd $SERVICE
    ln -s -n ../common common
    ln -s -n ../chatapp chatapp
    ln -s -n ../requirements.txt requirements.txt
    cd ..
done