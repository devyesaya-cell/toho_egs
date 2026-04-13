# Isar specific rules
-keep class com.isar_community.isar.** { *; }
-keep class * extends com.isar_community.isar.IsarCollection { *; }
-keep class * implements com.isar_community.isar.IsarCollection { *; }
-keep @com.isar_community.isar.Collection class * { *; }

# Keep your specific models if they are still being stripped
-keep class com.toho.toho_egs.core.models.** { *; }

# Keep Isar generated schema classes
-keep class **Schema { *; }
-keep class **Schema$* { *; }

# MapLibre GL Specific Rules
-keep class org.maplibre.** { *; }
-keep interface org.maplibre.** { *; }
-keep class com.mapbox.** { *; }
-keep interface com.mapbox.** { *; }

# Keep native methods for JNI
-keepclasseswithmembernames class * {
    native <methods>;
}
