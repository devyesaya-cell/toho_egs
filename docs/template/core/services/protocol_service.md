# Protocol Service Detail

Utility for low-level packet construction and byte manipulation.

## 1. Packet Structure
- Standard EGS packet format:
  `[Header (4 bytes)] [Length (1 byte)] [OpCode (1 byte)] [Payload] [Checksum (1 byte)]`

## 2. Byte Conversion
- Handles conversion between `double/float` and `Uint8List` (4 bytes).
- Implements Integer to 4-byte/2-byte serialization for serial transmission.

## 3. Reference
[ProtocolService](file:///c:/apps/toho_EGS/lib/core/protocol/protocol_service.dart)
