FROM python:3.10-slim

# Instalar dependencias del sistema necesarias para audio
RUN apt-get update && apt-get install -y ffmpeg && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copiar archivos del proyecto
COPY . /app

# Instalar dependencias de Python (Servidor)
RUN pip install --no-cache-dir -r requirements/server.txt

# Expone el puerto que Render  asignara
EXPOSE 9090

# Comando de inicio usando CPU y un modelo ligero
# Render inyecta la variable $PORT automáticamente
CMD ["python", "run_server.py", "--port", "9090", "--backend", "faster_whisper"]
