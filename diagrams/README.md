# Diagrams

| # | Source (editable) | Exports | Shows |
|---|---|---|---|
| 1 | [`src/01-system-context.puml`](src/01-system-context.puml) | [SVG](export/01-system-context.svg) · [PNG](export/01-system-context.png) | System context (C4 level 1) |
| 2 | [`src/02-use-case.puml`](src/02-use-case.puml) | [SVG](export/02-use-case.svg) · [PNG](export/02-use-case.png) | Use cases UC1–UC20 |
| 3 | [`src/03-component.puml`](src/03-component.puml) | [SVG](export/03-component.svg) · [PNG](export/03-component.png) | Component diagram (draft) |
| 4 | [`src/04-data-model.puml`](src/04-data-model.puml) | [SVG](export/04-data-model.svg) · [PNG](export/04-data-model.png) | Logical data model |
| 5 | [`src/05-sequence-trajectory-quiz.puml`](src/05-sequence-trajectory-quiz.puml) | [SVG](export/05-sequence-trajectory-quiz.svg) · [PNG](export/05-sequence-trajectory-quiz.png) | Check-in → micro-plan → adaptive quiz → mastery |
| 6 | [`src/06-sequence-video-generation.puml`](src/06-sequence-video-generation.puml) | [SVG](export/06-sequence-video-generation.svg) · [PNG](export/06-sequence-video-generation.png) | Asynchronous video generation |
| 7 | [`src/07-deployment.puml`](src/07-deployment.puml) | [SVG](export/07-deployment.svg) · [PNG](export/07-deployment.png) | Deployment view |

Description of every diagram: [docs/07-architecture.md](../docs/07-architecture.md).

## Regenerating the exports

PlantUML (Java 11+). Diagrams use the built-in `smetana` layout, so Graphviz is not required.

```bash
java -jar plantuml.jar -tsvg -o ../export diagrams/src/*.puml
java -jar plantuml.jar -tpng -o ../export diagrams/src/*.puml
```

The exports were generated with PlantUML 1.2025.4 (Maven Central `net.sourceforge.plantuml:plantuml`). Commit sources and exports together, in the same pull request.
