# Stage 1: Builder (apenas dependências)
FROM python:3.11-slim as builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir --user -r requirements.txt
# Stage 2: Runtime
FROM python:3.11-slim
# Atualizar pacotes do sistema (corrige CVEs perl-base: CVE-2026-13221, CVE-2026-42496, CVE-2026-8376)
RUN apt-get update && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY --from=builder /root/.local /root/.local
COPY . .
ENV PATH=/root/.local/bin:$PATH
ENV PYTHONUNBUFFERED=1
EXPOSE 8002
CMD ["python", "app.py"]