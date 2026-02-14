FROM rocm/pytorch:latest

WORKDIR /app

RUN git clone https://github.com/Comfy-Org/ComfyUI .

RUN pip install --upgrade pip
RUN pip install -r manager_requirements.txt -r requirements.txt
RUN find . -type f -name "requirements.txt" -exec pip install -r {} \;

# Patch cuda_malloc.py and model_management.py to not import comfy_aimdo
RUN sed -i '/import comfy_aimdo/d' cuda_malloc.py
RUN sed -i '/import comfy_aimdo/d' execution.py
RUN sed -i '/import comfy_aimdo/d' main.py
RUN sed -i '/import comfy_aimdo/d' comfy/model_management.py
RUN sed -i '/import comfy_aimdo/d' comfy/model_patcher.py
RUN sed -i '/import comfy_aimdo/d' comfy/ops.py

CMD [ "python", "main.py", "--enable-manager", "--preview-method", "auto" ]