python = python3
env_dir = venv
pip = $(env_dir)/bin/pip

.PHONY: install clean reinstall

install:
	$(python) -m venv $(env_dir)
	$(pip) install --upgrade pip
	$(pip) install -r requirements.txt
	$(pip) install -e django-shared-cash-boxes/

clean:
	rm -r $(env_dir)

reinstall: clean install
