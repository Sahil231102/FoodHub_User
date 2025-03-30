# Suppress warnings related to missing classes
-dontwarn com.google.android.apps.nbu.paisa.inapp.client.api.PaymentsClient
-dontwarn com.google.android.apps.nbu.paisa.inapp.client.api.Wallet
-dontwarn com.google.android.apps.nbu.paisa.inapp.client.api.WalletUtils
-dontwarn proguard.annotation.Keep
-dontwarn proguard.annotation.KeepClassMembers

# Keep Razorpay and Google Pay classes
-keep class com.razorpay.** { *; }
-keep class com.google.android.apps.nbu.paisa.** { *; }

# Keep Wallet and PaymentsClient
-keep class com.google.android.apps.nbu.paisa.inapp.client.api.** { *; }

# Keep annotation-related classes
-keep class proguard.annotation.Keep { *; }
-keep class proguard.annotation.KeepClassMembers { *; }

# Keep enums and avoid stripping them
-keepclassmembers enum * { *; }

# Keep all annotations
-keepattributes *Annotation*
