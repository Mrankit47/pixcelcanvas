# Project Packaging & Distribution

> **Phase**: 7 – Step 6  
> **Version**: 1.0.0  

---

## 1. Distribution Package Schema

`ProjectPackager` produces `.pixelcanvas` project manifests containing:

- `packageFormat`: Package format string
- `version`: Version string (`2.0.0`)
- `project`: Project metadata (name, resolution, layer count, animation clip count)
- `layersManifest`: Non-destructive layer stack descriptors
- `checksum`: Integrity checksum placeholder
