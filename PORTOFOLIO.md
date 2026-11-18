# Portofolio - Mysha Salma Aqila (2510512010)

## Kontribusi
Membuat `scripts/status_job.sh` untuk mencatat status pekerjaan
(MENUNGGU, BERJALAN, BERHASIL/GAGAL), merekam PID, dan menangkap exit status.

## Skenario Uji
- (+) `sleep 1` tercatat MENUNGGU -> BERJALAN -> BERHASIL, exit 0
- (-) `bash -c 'exit 3'` tercatat GAGAL dengan PID dan exit 3

## Analisis Konsep SO: Proses
Setiap pekerjaan dijalankan sebagai proses anak oleh shell (fork + exec) dan
diberi PID unik oleh kernel. Siklus hidupnya: menunggu (new/ready), berjalan
(running), lalu terminated. Proses induk memakai `wait` untuk mengambil exit
status anak ($?). Exit 0 berarti sukses, nilai non-nol berarti gagal.

## Bukti
- Commit: 6af9738
- evidence/status_test.txt
- Fork: https://github.com/mysha11033/sistem-antrean-5b
