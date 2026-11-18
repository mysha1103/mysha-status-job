#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "== (+) Pekerjaan normal (sleep 1) =="
echo '$ scripts/status_job.sh sleep 1'
"$DIR/scripts/status_job.sh" sleep 1
echo "exit status: $?"
echo

echo "== (-) Pekerjaan error (exit 3) =="
echo "\$ scripts/status_job.sh bash -c 'exit 3'"
"$DIR/scripts/status_job.sh" bash -c 'exit 3'
echo "exit status: $?"
echo

echo "== (-) Tanpa parameter =="
echo '$ scripts/status_job.sh'
"$DIR/scripts/status_job.sh"
echo "exit status: $?"
echo

echo "== Isi log (logs/status_job.log) =="
tail -n 6 "$DIR/logs/status_job.log"

