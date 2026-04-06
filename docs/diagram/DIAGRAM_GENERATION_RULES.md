# Diagram Generation Rules

This document outlines the standard process for generating Detailed C4 Level 4 Component Diagrams for this project.

## Workflow Trigger
To request a new diagram, use the following prompt format:
> "Make Diagram Detail for @[file.dart]"

## Output Location
All generated diagrams must be saved in the `docs/` folder.

## File Naming Convention
- **Pages**: `c4_lv4_[page_name].drawio` (e.g., `c4_lv4_dashboard_page.drawio`)
- **Presenters**: `[feature]_presenter_class_diagram.drawio` (e.g., `map_presenter_class_diagram.drawio`)
- **Other Components**: `c4_lv4_[component_name].drawio`

## Diagram Standards
- **Format**: Draw.io XML embedded in the `.drawio` file.
- **Style**: C4 Component Diagram (Level 4 - Code Level).

### Diagram Structure
1.  **Main Container**: Represents the Class or Component (e.g., `DashboardPage Component`).
    -   Style: Swimlane or Group container.
2.  **Internal Blocks**: Represent Methods or Logical Functions.
    -   One block per significant method.

### Block Details
Each internal block must contain the following information:
-   **Header**: Method Name (e.g., `build()`, `_calculateTrend()`).
-   **Content Body**:
    -   **In**: Input parameters.
    -   **Out**: Return type.
    -   **Models**: Key classes, entities, or widgets used.
    -   **Desc**: A concise functional description of what the method does.

### Color Coding Scheme
-   **Grey/White** (`#f5f5f5`): Standard Methods / UI Builders.
-   **Blue** (`#dae8fc`): State Management / Listeners / Logic Helpers.
-   **Green** (`#d5e8d4`): Initialization / Setup / Data Loading.
-   **Purple** (`#e1d5e7`): Data Transformation / Math / Complex Logic.
-   **Orange** (`#ffe6cc`): User Interaction / Event Handlers.

## Example XML Snippet
```xml
<!-- Method: Example -->
<mxCell id="m_example" value="" style="group" vertex="1" connectable="0" parent="main_container">
    ...
</mxCell>
<mxCell id="m_example_bg" value="" style="rounded=1;fillColor=#f5f5f5;..." vertex="1" parent="m_example">
    ...
</mxCell>
<mxCell id="m_example_content" value="&lt;b&gt;In:&lt;/b&gt; params...&lt;br&gt;&lt;b&gt;Desc:&lt;/b&gt; Description..." ... />
```
