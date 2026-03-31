# Resource# Management Feature Detail

The Management page is a centralized administrative hub for managing operators, machines, work sites, and historical data. It uses a `DefaultTabController` with a scrollable `TabBar` to accommodate 6 distinct functional areas.

## Page Structure
- **TabBar**: Fixed at the bottom of the `AppBar`, marked with `isScrollable: true`.
- **View**: A `TabBarView` hosting standalone widget tabs.

## Management Resource Tabs
- [**PERSON**](file:///c:/apps/toho_EGS/docs/template/setup/management/person_tab.md): Operator/User profiles and authentication roles.
- [**WORKFILE**](file:///c:/apps/toho_EGS/docs/template/setup/management/workfile_tab.md): Job-specific DXF/Surface and progress data.
- [**CONTRACTOR**](file:///c:/apps/toho_EGS/docs/template/setup/management/contractor_tab.md): Company/Contractor listing and resources.
- [**EQUIPMENT**](file:///c:/apps/toho_EGS/docs/template/setup/management/equipment_tab.md): Machine specs, model, and arm geometry.
- [**AREA**](file:///c:/apps/toho_EGS/docs/template/setup/management/area_tab.md): Site geographical zones and target deadlines.
- [**TIMESHEETDATA**](file:///c:/apps/toho_EGS/docs/template/setup/management/timesheet_data_tab.md): Activity mapping for work hour records.

## UI Generation Rules
- **Responsive Grid**: Uses `LayoutBuilder` to dynamicly adjust columns from 2 (Mobile) up to 5 (Large Desktop).
- **Cards**: Every tab uses a consistent Card style with defined `childAspectRatio`.
- **Streams**: Uses `StreamBuilder` connected to `appRepository` for real-time reactivity.

---
> [!NOTE]
> Management tabs are the primary entry points for populating the Isar database with foundational data.
