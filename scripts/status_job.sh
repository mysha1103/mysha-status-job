#!/bin/bash
# status_job.sh - menjalankan satu pekerjaan, mencatat siklus statusnya:
# MENUNGGU -> BERJALAN -> BERHASIL / GAGAL, lengkap dengan PID dan exit status.
# Penggunaan : scripts/status_job.sh <perintah> [argumen...]
# Exit status: 0 = berhasil, 2 = parameter kosong, lainnya = exit status asli pekerjaan

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOG_DIR="$BASE_DIR/logs"
LOG_FILE="$LOG_DIR/status_job.log"

if [ $# -lt 1 ]; then
  echo "Penggunaan: $0 <perintah> [argumen...]" >&2
  exit 2
fi

mkdir -p "$LOG_DIR"
JOB_ID="job-$(date +%s)-$$"
NAMA_JOB="$*"

# $1=status $2=pid $3=exit
catat() {
  printf '%s | %s | PID=%s | STATUS=%s | EXIT=%s | CMD=%s\n' \
    "$(date '+%F %T')" "$JOB_ID" "$2" "$1" "$3" "$NAMA_JOB" | tee -a "$LOG_FILE"
}

catat "MENUNGGU" "-" "-"

"$@" &
PID=$!
catat "BERJALAN" "$PID" "-"

wait "$PID"
KODE=$?

if [ "$KODE" -eq 0 ]; then
  catat "BERHASIL" "$PID" "$KODE"
else
  catat "GAGAL" "$PID" "$KODE"
fi

exit "$KODE"
