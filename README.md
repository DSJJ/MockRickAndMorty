#MockRickAndMorty

Una aplicación construida con **SwiftUI**, **SwiftData**, **async/await** y arquitectura **MVVM**,  
que consume la API oficial de [Rick and Morty](https://rickandmortyapi.com) para mostrar personajes, sus episodios y gestionar favoritos de forma persistente.

---

## 📱 Características

- 🔍 Búsqueda por nombre
- 🧬 Filtros por especie y estado
- ♻️ Scroll infinito con paginación automática y soporte para pull-to-refresh
- 🌎 Vista de mapa para la última ubicación del personaje (simulada con la ubicación de las oficinas reales en California)
- ⭐ Guardado de personajes favoritos con persistencia local usando **SwiftData**
- 👁️ Registro de episodios vistos con persistencia usando **SwiftData**
- 🔐 Protección biométrica (Face ID / Touch ID) para acceder a favoritos
- ✅ Soporte completo para modo oscuro y rotación de pantalla

---

## 🧱 Arquitectura

El proyecto sigue una arquitectura basada en **MVVM puro**, separando claramente la lógica de negocio de la interfaz de usuario

---

## 🚀 Instalación

1. Clona el repositorio:

```bash
git clone https://github.com/DSJJ/MockRickAndMorty.git
```

2. Abre el proyecto en Xcode:

```bash
open The Rick and Morty.xcodeproj
```

3. Ejecuta en un simulador o dispositivo real.

> **Requisitos**:
> - Xcode 15 o superior  
> - iOS 17 o superior  
> - Soporte para Swift Concurrency (`async/await`) y SwiftData

---

## 🧪 Pruebas

El proyecto incluye pruebas unitarias para `CharactersViewModel` usando el módulo de pruebas de Swift moderno (`Testing`):

- Mock de servicios (`MockRickAndMortyService`)
- Pruebas de éxito, error y manejo de estado de la vista

---

## 🔐 Permisos

Agrega esta clave en tu `Info.plist` para permitir el uso de biometría:

```xml
<key>NSFaceIDUsageDescription</key>
<string>Esta aplicación requiere Face ID para acceder a la sección de favoritos.</string>
```

---

## 🧾 Licencia

MIT License. Puedes usar, modificar y distribuir este proyecto con fines educativos o comerciales.

---

## 📸 Capturas 

![IMG_6305](https://github.com/user-attachments/assets/b706a000-460b-4bb3-8085-4631b3970700)
![IMG_6306](https://github.com/user-attachments/assets/d3254a71-d792-44ec-8d26-97774cf69fde)
![IMG_6303](https://github.com/user-attachments/assets/d895d4d7-f36d-4ae4-bde0-ab355d7ebc22)
![IMG_6308](https://github.com/user-attachments/assets/5ede5b24-0f34-451a-a8c7-f5a074a3a1fe)
![IMG_6302](https://github.com/user-attachments/assets/bb6b2efc-826c-435c-938f-43393b35a18d)
![IMG_6304](https://github.com/user-attachments/assets/6c80d846-f5a3-4b15-8f2c-1577ca48af8b)
![IMG_6307](https://github.com/user-attachments/assets/7f6447a8-5bce-4555-914e-8aa4064d4659)


---

## 🤝 Créditos

- API: [Rick and Morty API](https://rickandmortyapi.com)
- Mapas: MapKit (con coordenadas simuladas)
- Iconografía: SF Symbols

---
