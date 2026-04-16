# WARP3 Wallbox Ladeabrechnung

Konsolidierte Ladeabrechnung für mehrere [Tinkerforge WARP3](https://www.warp-charger.com/) Wallboxen. Web-App mit Benutzer-/Monatsfilter und PDF-Export im Original-WARP3-Format.

![Node.js](https://img.shields.io/badge/Node.js-18+-green) ![License](https://img.shields.io/badge/License-MIT-blue)

## Features

- **Automatische Erkennung** der Wallboxen im Netzwerk per mDNS
- **Alle Ladevorgänge** von mehreren WARP3 Wallboxen konsolidiert
- **Benutzer-, Monats- und Jahresfilter** – Auswahl wird sofort übernommen
- **Strompreis** und **Benutzernamen** direkt aus der Wallbox-API
- **PDF-Export** im Original-WARP3-Ladelog-Format (Layout aus dem [Firmware-Quellcode](https://github.com/Tinkerforge/esp32-firmware/blob/master/software/src/modules/charge_tracker/pdf_charge_log.cpp))
- **Briefkopf/Firmenadresse** über die Weboberfläche konfigurierbar
- **Daten-Caching** – schnelle Seitenaufrufe, manuelles Aktualisieren möglich

## Screenshot

Die Weboberfläche zeigt alle Ladevorgänge mit Startzeit, Benutzer, Wallbox, Zählerstand, geladene kWh, Ladedauer und Kosten.

## Installation

```bash
git clone https://github.com/<your-user>/warp3-charge-log.git
cd warp3-charge-log
cp config.yaml.example config.yaml
npm install
```

## Konfiguration

`config.yaml` anpassen (optional – Wallboxen werden automatisch per mDNS gefunden):

```yaml
# Optional: Wallboxen manuell angeben
wallboxes:
  - host: "warp3-AbCd"
  - host: "warp3-EfGh"

# Firmenadresse (auch über Weboberfläche änderbar)
company:
  name: "Musterfirma GmbH"
  street: "Musterstraße 1"
  city: "12345 Musterstadt"

port: 3000
```

## Starten

```bash
npm start
```

→ http://localhost:3000

## Verwendung

1. **Filtern** – Benutzer, Jahr und Monat über die Dropdowns auswählen (wird sofort übernommen)
2. **PDF Export** – Erzeugt ein PDF im Original-WARP3-Format mit Logo, Briefkopf und Tabelle
3. **⚙ Briefkopf** – Firmenadresse für den PDF-Header konfigurieren
4. **↻ Aktualisieren** – Cache leeren und frische Daten von den Wallboxen holen

## Genutzte WARP3 API-Endpunkte

| Endpunkt | Beschreibung |
|---|---|
| `GET /charge_tracker/charge_log` | Binäres Ladelog aller Ladevorgänge (inkl. Zählerstand) |
| `GET /charge_tracker/config` | Strompreis (`electricity_price` in ct/kWh × 100) |
| `GET /users/config` | Benutzerliste mit IDs und Anzeigenamen |
| `GET /info/name` | Wallbox-Hostname und Gerätetyp |

## Technische Details

- **Node.js / Express** mit EJS-Templates
- **Eigener PDF-Generator** (`simplepdf.js`) – kein pdfkit/puppeteer, minimaler Speicherverbrauch
- **mDNS-Discovery** via `bonjour-service` – findet WARP-Charger automatisch im LAN
- **PDF-Layout** basiert auf den Original-Konstanten aus der [WARP-Firmware](https://github.com/Tinkerforge/esp32-firmware) (Spaltenoffsets, Margins, Font Size)
- **Kostenberechnung** identisch zur Firmware: `Math.round(energy_kwh * price_ct)` in Cent, Summierung der gerundeten Werte

## Lizenz

MIT
