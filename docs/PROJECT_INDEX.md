# Project Index & Catalog Architecture

> **Phase**: 7 – Step 2  
> **Version**: 1.0.0  

---

## 1. Catalog Index Schema

`ProjectIndex` maintains the collection of `ProjectMetadata` records:

- `id`: `String` (Unique ID)
- `name`: `String` (Project title)
- `filePath`: `String` (File path)
- `width`, `height`: `int` (Dimensions)
- `createdDate`, `modifiedDate`, `lastOpened`: `DateTime`
- `tags`: `List<String>`
- `isFavorite`, `isArchived`, `isPinned`: `bool`
- `backgroundColorHex`: `String`
- `previewPngBase64`: `String?`
