#include "ShrikeFPGA.h"

ShrikeFPGA::ShrikeFPGA(uint8_t fpgaPwr, uint8_t fpgaEn, uint8_t fpgaReset,
                       uint8_t sck, uint8_t tx, uint8_t rx, uint8_t cs)
  : _fpgaPwr(fpgaPwr), _fpgaEn(fpgaEn), _fpgaReset(fpgaReset),
    _sck(sck), _tx(tx), _rx(rx), _cs(cs),
    _spiSettings(2000000, MSBFIRST, SPI_MODE0) {}

bool ShrikeFPGA::initShrike() {
  Serial.println("\n[ ShrikeFPGA Init ]");

  _fpgaPowerOn();

  if (!LittleFS.begin()) {
    Serial.println("LittleFS Mount Failed!");
    return false;
  }
  Serial.println("LittleFS Mounted Successfully!");

  _initSPI();
  return true;
}

void ShrikeFPGA::_fpgaPowerOn() {
  pinMode(_fpgaPwr, OUTPUT);
  pinMode(_fpgaEn, OUTPUT);
  pinMode(_fpgaReset, OUTPUT);

  digitalWrite(_fpgaPwr, HIGH);
  delay(10);
  digitalWrite(_fpgaEn, HIGH);
  delay(10);

  digitalWrite(_fpgaReset, LOW);
  delay(20);
  digitalWrite(_fpgaReset, HIGH);
  delay(50);
}

void ShrikeFPGA::_initSPI() {
  SPI.setRX(_rx);
  SPI.setTX(_tx);
  SPI.setSCK(_sck);
  SPI.setCS(_cs);
  SPI.begin(true);  // master
  pinMode(_cs, OUTPUT);
  digitalWrite(_cs, HIGH);
}

void ShrikeFPGA::listFiles() {
  File root = LittleFS.open("/", "r");
  if (!root) {
    Serial.println("Failed to open root directory!");
    return;
  }

  Serial.println("\n=== Files in LittleFS ===");
  File file = root.openNextFile();
  while (file) {
    Serial.printf("  %s (%u bytes)\n", file.name(), file.size());
    file = root.openNextFile();
  }
  Serial.println("=========================");
}

bool ShrikeFPGA::programShrike(const char* filename) {
  File binFile = LittleFS.open(filename, "r");
  if (!binFile) {
    Serial.println("Failed to open bitstream file!");
    return false;
  }

  Serial.printf("Programming FPGA with file: %s\n", filename);
  uint32_t totalSize = binFile.size();
  uint8_t buffer[256];
  uint32_t totalSent = 0;
  uint32_t tStart = millis();

  SPI.beginTransaction(_spiSettings);
  digitalWrite(_cs, LOW);
  delayMicroseconds(10);

  while (binFile.available()) {
    size_t bytesRead = binFile.read(buffer, sizeof(buffer));
    for (size_t i = 0; i < bytesRead; i++) {
      SPI.transfer(buffer[i]);
    }
    totalSent += bytesRead;
    Serial.printf("Sent %lu / %lu bytes\r\n", totalSent, totalSize);
  }

  delayMicroseconds(10);
  digitalWrite(_cs, HIGH);
  SPI.endTransaction();
  binFile.close();

  uint32_t tElapsed = millis() - tStart;
  Serial.printf("FPGA Programming Complete! (%lu bytes in %lu ms)\n",
                totalSent, tElapsed);
  return true;
}
