# Settings Storage & Profile Serialization

> **Phase**: 7 – Step 4  
> **Version**: 1.0.0  

---

## 1. Storage & Export Schema

`SettingsStorage`, `SettingsExporter`, and `SettingsImporter` handle profile JSON serialization:

- `SettingsProfile.toJson()` converts all configuration categories (General, Appearance, Editor, Performance, Autosave, Shortcuts) into formatted JSON strings.
- Profiles can be saved, exported to disk, or imported to restore custom setups.
