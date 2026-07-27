# Template Architecture

> **Phase**: 7 – Step 3  
> **Version**: 1.0.0  

---

## 1. Schema Specifications

`TemplateMetadata` schema:
- `id`: `String`
- `name`: `String`
- `description`: `String`
- `category`: `TemplateCategory`
- `width`, `height`: `int`
- `layerCount`: `int`
- `hasAnimation`: `bool`
- `tags`: `List<String>`
- `isFavorite`, `isBuiltIn`: `bool`
