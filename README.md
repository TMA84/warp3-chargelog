# WARP3 Wallbox Ladeabrechnung

Node.js Web-App zur konsolidierten Ladeabrechnung für mehrere Tinkerforge WARP3 Wallboxen. Liest Ladedaten und Strompreis direkt aus den Wallboxen, bietet Benutzer-/Datumsfilter und PDF-Export im Original-WARP3-Format.

## Features

- Abruf aller Ladevorgänge von mehreren WARP3 Wallboxen via HTTP API
- Web-Oberfläche mit Benutzer- und Datumsfilter
- Strompreis wird direkt aus der Wallbox-Konfiguration gelesen
- PDF-Export im Original-WARP3-Ladelog-Format (mit Firmenadresse, Zählerstand, etc.)

## Installation

```bash
cd warp3-charge-log
npm install
```

## Konfiguration

In `config.yaml` die Wallboxen und Firmenadresse eintragen:

```yaml
wallboxes:
  - name: "Wallbox Garage"
    host: "warp3-AbCd"
  - name: "Wallbox Carport"
    host: "warp3-EfGh"

company:
  name: "Musterfirma GmbH"
  street: "Musterstraße 1"
  city: "12345 Musterstadt"

port: 5000
```

## Starten

```bash
npm start
```

Dann im Browser: http://localhost:5000

- Benutzer und Zeitraum über die Filterleiste auswählen
- "PDF Export" erzeugt ein PDF im Original-WARP3-Format

## API-Endpunkte (WARP3)

| Endpunkt | Beschreibung |
|---|---|
| `/charge_tracker/charge_log` | Binäres Ladelog (alle Ladevorgänge, inkl. Zählerstand) |
| `/charge_tracker/config` | Strompreis (`electricity_price` in ct/kWh × 100) |
| `/users/config` | Benutzerliste mit IDs und Anzeigenamen |
