FROM rocm/pytorch:latest
WORKDIR /app

# Clone ComfyUI repository
RUN git clone https://github.com/Comfy-Org/ComfyUI .

# Define entrypoint script
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT [ "/app/entrypoint.sh" ]