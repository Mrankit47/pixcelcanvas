# PixelCanvas — Known Limitations & Future Version Roadmap

> **Phase**: 7 – Step 7  
> **Version**: 1.0.0-RC1  

---

## 1. Documented Known Limitations

1. **Software CPU Rasterization**: Large canvas resolutions above $1024 \times 1024$ pixels use CPU rasterization and may drop frames on low-end mobile hardware.
2. **Color Space**: 32-bit ARGB (8 bits per channel) color space. High dynamic range (16-bit) channels not supported in v1.0.
3. **GIF Binary Export**: Animated GIF export uses pure Dart encoder; complex palette dithering in GIFs will be enhanced in v1.1.
