# ProjectProgramSkill
some useful project program skill,like shared library,callback function,etc.

## Project init

```shell
git clone xxx.git

cd ProjectProgramSkill

chmod +x init.sh

./init.sh
```

## Project docs

refs the docs/doc-guide/sphinx,use `make htmldocs` generate the htmldocs.

```shell
# get a environment
python -m venv sphinx_2.4.4

# activate the environment
. ./sphinx_2.4.4/bin/activate

# install dependency package
pip install -r docs/sphinx/requirements.txt

# make the htmldocs in docs/out
make htmldocs
```
