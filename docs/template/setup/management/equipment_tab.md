# Equipment Tab Detail

The Equipment tab manages machine profiles and physical arm parameters.

## UI Features
- **Primary Action**: `ADD EQUIPMENT` button.
- **Grid View**: `EquipmentCardWidget` displaying model and unit number.

## Predefined Lists
- **Models**: Hitachi, Komatsu, Sunny, Caterpillar, Volvo, Doosan, Sany.
- **Types**: Excavator, Dozer, Grader, Truck, Compactor, Wheel Loader, Crane.

## Form Fields (EquipmentEditDialog)
- **EQUIP NAME**: Text.
- **PART NAME**: Text (e.g., Bucket, Boom).
- **UNIT NUMBER**: Unique identifier text.
- **ARM LENGTH**: Double (meters).
- **MODEL**: Dropdown selection.
- **TYPE**: Dropdown selection.
