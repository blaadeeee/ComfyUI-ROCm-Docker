#!/bin/bash

# Copy default venv state
/opt/venv/bin/pip install virtualenv-clone
/opt/venv/bin/virtualenv-clone /opt/venv /app/venv/venv

# Install all dependencies found
/app/venv/venv/bin/pip install --upgrade pip;
/app/venv/venv/bin/pip install -r manager_requirements.txt -r requirements.txt;
find . -type f -name "requirements.txt" -exec /app/venv/venv/bin/pip install -r {} \;

# Start ComfyUI
/app/venv/venv/bin/python main.py --enable-manager --preview-method auto