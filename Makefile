env_dir:=venv
pip:=$(env_dir)/bin/pip

install:
	python3 -m venv $(env_dir)
	$(pip) install --upgrade pip
	$(pip) install -r requirements.txt
	git submodule update --recursive --init
	$(pip) install -e django-shared-cash-boxes/

clean:
	rm -r $(env_dir)

reinstall:
	make clean install
