#!/bin/bash

# Stop on error
set -e

# Delete app virtual environment if upgrading
if [ "$RESET_VENV" = "1" ]; then
    rm -rf /app/venv/venv
fi

# Check if app local virtual environment already exists
if [ ! -d "/app/venv/venv" ]; then

    # Copy default ROCm virtual environment state
    /opt/venv/bin/pip install virtualenv-clone;
    /opt/venv/bin/virtualenv-clone /opt/venv /app/venv/venv;

    # Install all dependencies found
    /app/venv/venv/bin/pip install --upgrade pip;
    /app/venv/venv/bin/pip install -r manager_requirements.txt -r requirements.txt;
    find . -type f -name "requirements.txt" -exec /app/venv/venv/bin/pip install -r {} \;

fi

# Start ComfyUI
/app/venv/venv/bin/python main.py --enable-manager --preview-method auto;