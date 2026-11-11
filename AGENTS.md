# AGENTS.md

## Forma de trabajo

Este proyecto se desarrolla de manera incremental mediante consultas, ajustes pequeños y funcionalidades construidas progresivamente. Adapte el esfuerzo al alcance y riesgo real de cada solicitud; no aplique procesos extensos a tareas triviales.

## Consultas

Cuando la solicitud sea una pregunta, explicación, revisión o diagnóstico:

- Responda directamente.
- Inspeccione archivos solo cuando sea necesario.
- No modifique el proyecto sin una petición explícita.
- No ejecute pruebas o compilaciones salvo que ayuden a confirmar la respuesta.
- No convierta una consulta sencilla en un plan de implementación extenso.

## Cambios pequeños

Para correcciones o ajustes localizados:

- Revise los archivos directamente relacionados.
- Preserve cambios existentes.
- Realice el cambio mínimo necesario.
- Respete el estilo y arquitectura actuales.
- Ejecute únicamente la verificación relevante.
- Informe brevemente qué cambió y si quedó algo pendiente.

No es obligatorio ejecutar toda la suite de pruebas para cambios triviales o exclusivamente documentales.

## Cambios importantes

Para funcionalidades completas, cambios estructurales, migraciones, seguridad, datos, autenticación o dependencias:

- Revise la arquitectura y documentación relevante.
- Explique supuestos importantes.
- Evalúe riesgos y compatibilidad.
- Añada o actualice pruebas.
- Ejecute formato, análisis y pruebas correspondientes.
- Actualice documentación cuando cambie el uso, configuración o arquitectura.

## Reglas permanentes

- No sobrescriba trabajo existente.
- No realice acciones destructivas sin autorización.
- No incluya secretos ni datos sensibles.
- No añada dependencias sin una necesidad clara.
- Evite refactorizaciones fuera del alcance solicitado.
- Prefiera soluciones simples y coherentes con el proyecto.
- No afirme haber ejecutado verificaciones que no se realizaron.
- Pregunte únicamente cuando una decisión faltante pueda cambiar materialmente el resultado.

## Cerebro Flutter

El conocimiento general de ingeniería Flutter está disponible en:

`C:\Flutter\Cerebro Flutter`

Consúltelo únicamente cuando la tarea requiera decisiones de arquitectura, dependencias, seguridad, testing, documentación, depuración compleja o creación de funcionalidades.

Comience por:

`C:\Flutter\Cerebro Flutter\Cerebro Flutter.md`

Lea solamente las notas relacionadas con la tarea; no cargue toda la bóveda para consultas o cambios pequeños.

Las reglas y documentación específicas del proyecto tienen prioridad sobre las recomendaciones generales del Cerebro Flutter.

Si la ruta no está disponible en el entorno de ejecución, continúe con la documentación del proyecto e informe brevemente que no fue posible consultar la bóveda.

## Mantenimiento autónomo del conocimiento

Después de una tarea relevante, determine si produjo conocimiento reutilizable. No pida al usuario que transcriba, clasifique o enlace notas manualmente.

Actualice el Cerebro Flutter automáticamente cuando exista:

- Una decisión arquitectónica importante.
- Un error difícil con causa raíz y solución verificable.
- Una dependencia evaluada o una condición para reemplazarla.
- Una práctica reutilizable en otros proyectos.
- Un cambio significativo de arquitectura, configuración o estado del proyecto.

No actualice la bóveda por consultas casuales, cambios triviales, hipótesis sin confirmar, información duplicada o detalles exclusivos del código que ya están documentados en el repositorio.

Antes de escribir:

1. Consulte `C:\Flutter\Cerebro Flutter\08 - Agentes\Protocolo de mantenimiento autonomo.md`.
2. Busque una nota existente sobre el mismo tema.
3. Actualice y enlace la nota existente antes de crear otra.
4. Excluya secretos, credenciales, datos personales y grandes fragmentos de código.
5. Mantenga la información específica para compilar u operar el proyecto dentro de su repositorio.

Si la bóveda no está disponible o no permite escritura, guarde el aprendizaje como una propuesta pendiente en `.cerebro-flutter/pendientes/` dentro del proyecto, siempre que pueda hacerlo sin alterar el producto. Sincronícela automáticamente en una sesión futura con acceso a la bóveda.

Cuando actualice el Cerebro Flutter, comuníquelo al final en una sola línea. No convierta el mantenimiento de conocimiento en el centro de la respuesta.

## Flutter

Cuando sean relevantes para el cambio:

- Mantenga null safety.
- Libere controladores, listeners y suscripciones.
- Evite efectos secundarios dentro de `build`.
- Modele adecuadamente carga, datos, vacío y error.
- Considere seguridad, accesibilidad y rendimiento según el riesgo.

## Verificación proporcional

Seleccione solamente lo necesario:

```powershell
dart format .
flutter analyze
flutter test
```

No ejecute automáticamente todos los comandos. Use análisis o pruebas específicas cuando sean suficientes.

## Entrega

Mantenga la respuesta proporcional a la tarea:

- Para consultas: respuesta directa.
- Para cambios pequeños: resumen breve y verificación realizada.
- Para cambios importantes: resumen, decisiones, pruebas, riesgos y pendientes.
