#!/bin/bash
set -u

# ====== Config ======
DEVICE_RPI_LABEL="RPI-RP2"
DEVICE_SHRIKE_UUID="5221-0000"   # UUID for MicroPython drive

FILES_RPI=(
  "./../../shrike-lite_v_1.uf2"
)
FILES_SHRIKE=(
  "./../bitstreams/v1_4/blink_all.bin"
  "./main.py"
)

MOUNT_DIR="/mnt/usb"
SLEEP_INTERVAL=2
# ====================

mkdir -p "$MOUNT_DIR"

log() { echo "[$(date '+%H:%M:%S')] $*"; }

run_mpremote_after_copy() {
  local timeout_sec=60   # max time to wait for /dev/ttyACM0
  local mpremote_timeout=8  # max time to allow mpremote to run

  log "Waiting for MicroPython serial device..."
  for ((i=0; i<timeout_sec; i++)); do
    if [[ -e /dev/ttyACM0 ]]; then
      sleep 2
      log "Found serial: /dev/ttyACM0"
      log "Running main.py via mpremote (timeout ${mpremote_timeout}s)..."

      # --- Run with timeout ---
      if timeout "$mpremote_timeout" mpremote connect /dev/ttyACM0 run main.py; then
        log "mpremote: completed successfully"
      else
        log "WARN: mpremote timed out or failed"
      fi
      return
    fi
    sleep 1
  done

  log "WARN: serial /dev/ttyACM0 not found after ${timeout_sec}s."
}

copy_and_eject() {
  local device_node="$1"
  local id_str="$2"
  local -n files_arr=$3
  local auto_run="${4:-0}"   # 1 if we should run mpremote afterward

  # detect or create mountpoint
  local mountpoint
  mountpoint=$(findmnt -n -o TARGET -S "$device_node" 2>/dev/null || true)
  if [[ -z "$mountpoint" ]]; then
    mountpoint="$MOUNT_DIR"
    log "Mounting $device_node -> $mountpoint"
    if ! sudo mount "$device_node" "$mountpoint"; then
      log "ERROR: mount failed for $device_node"
      return 1
    fi
  else
    log "Using existing mountpoint: $mountpoint"
  fi

  # copy each file
  for f in "${files_arr[@]}"; do
    if [[ -e "$f" ]]; then
      log "Copy: $f -> $mountpoint/"
      if ! cp -r "$f" "$mountpoint/"; then
        log "WARN: failed to copy $f"
      else
        log "OK: copied $(basename "$f")"
      fi
    else
      log "WARN: source file not found: $f"
    fi
  done

  sync
  log "Sync complete."

  # unmount + power off
  log "Unmounting $mountpoint"
  sudo umount "$mountpoint" || log "WARN: umount failed"
  log "Eject/power-off $device_node"
  #sudo udisksctl power-off -b "$device_node" >/dev/null 2>&1 || log "WARN: udisksctl power-off failed"

  # optional: run mpremote after eject (for Shrike only)
  if [[ "$auto_run" -eq 1 ]]; then
    run_mpremote_after_copy
  fi
}

log "Service started. Watching for label='$DEVICE_RPI_LABEL' or uuid='$DEVICE_SHRIKE_UUID'"

while true; do
  for DEV in $(lsblk -rpo NAME,TYPE | awk '$2=="part" || $2=="disk" {print $1}'); do
    LABEL=$(blkid -s LABEL -o value "$DEV" 2>/dev/null || echo "")
    UUID=$(blkid -s UUID -o value "$DEV" 2>/dev/null || echo "")

    # --- match RPI by LABEL (exact) ---
    if [[ -n "$LABEL" && "$LABEL" == "$DEVICE_RPI_LABEL" ]]; then
      log "Matched RPI by label ($LABEL) on $DEV"
      copy_and_eject "$DEV" "$LABEL" FILES_RPI

      # === wait for Shrike device after flash ===
      log "Waiting for Shrike (UUID=$DEVICE_SHRIKE_UUID) to appear..."
      for i in {1..40}; do
        SHR_DEV=$(lsblk -rpo NAME,UUID | awk -v u="$DEVICE_SHRIKE_UUID" '$2==u {print $1}')
        if [[ -n "$SHR_DEV" ]]; then
          log "Found Shrike device at $SHR_DEV"
          copy_and_eject "$SHR_DEV" "$DEVICE_SHRIKE_UUID" FILES_SHRIKE 1
          break
        fi
        sleep 1
      done
      continue
    fi
  done

  sleep "$SLEEP_INTERVAL"
done
