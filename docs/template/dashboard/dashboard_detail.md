# Dashboard Feature Detail

This document provides a technical breakdown of the Dashboard feature, serving as a blueprint for generating similar data-driven summary pages.

## 1. Page Layout
- **Type**: `ConsumerWidget`
- **Structure**:
  - `Scaffold` (Background: `theme.pageBackground`)
  - `AppBar`: Includes a dashboard icon, title ("EGS DASHBOARD"), and `GlobalAppBarActions`.
  - `Body`: A vertical `Column` containing:
    1. **DashboardHeader**: Filter and selection controls.
    2. **Content Area**: An `Expanded` region that uses `Riverpod`'s `.when` to handle Data, Loading, and Error states.

## 2. Core Widgets
These widgets are used to build the dashboard content:

### A. [DashboardHeader](file:///c:/apps/toho_EGS/lib/features/dashboard/widgets/dashboard_header.dart)
- **Role**: Filter management.
- **Components**:
  - `FilterChips`: Morning, Night, Weekly, Monthly (Horizontal scroll).
  - `DateRangeButton`: Opens a calendar to select a custom range.
  - `WorkfileDropdown`: Selects the active job/workfile.

### B. [ProgressCard](file:///c:/apps/toho_EGS/lib/features/dashboard/widgets/progress_card.dart)
- **Role**: Primary KPI visualization.
- **Details**: Displays total area (Ha) and spot progress using circular or linear indicators.

### C. [SummaryCard](file:///c:/apps/toho_EGS/lib/features/dashboard/widgets/summary_card.dart)
- **Role**: Secondary metrics.
- **Instances**: Productivity (Blue), Precision (Red), Production (Green), Work Hours (Purple).
- **Properties**: Title, Value, Unit, Sub-Value, and a small progress bar.

### D. [TrendChart](file:///c:/apps/toho_EGS/lib/features/dashboard/widgets/trend_chart.dart)
- **Role**: Historical data visualization.
- **Library**: `fl_chart`.
- **Instances**: Productivity Trend, Production Trend.

## 3. State Management (Presenter)
- **Provider**: `dashboardPresenterProvider` (AsyncNotifier).
- **State Object**: `DashboardData`.
- **Logic**:
  - Fetches data from `AppRepository` based on the active filter (Date range, File ID).
  - Handles real-time updates when the underlying database changes.

## 4. UI Generation Rules
- **Responsive Grid**: Use `Expanded` with `flex` factors (e.g., 6:4 ratio between top cards and bottom charts).
- **Semantics**: Use specific colors for metrics (Productivity = Blue, Production = Green).
- **Scalability**: All widget names in this doc should be considered placeholders (e.g., "SummaryCard" can be renamed to "KpiCard" in new projects).

---
> [!TIP]
> To generate a new dashboard, provide the AI with a list of KPIs and the data model, and it will use this structure to assemble the page.
