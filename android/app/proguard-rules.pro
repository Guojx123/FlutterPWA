# ProGuard 混淆规则配置

# 保持 Flutter 相关类
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# 保持 GetX 相关类
-keep class com.get.** { *; }

# 保持数据模型类（避免序列化问题）
-keep class com.example.template.models.** { *; }

# 保持 R 文件
-keep class **.R$* { *; }

# 移除日志
-assumenosideeffects class android.util.Log {
    public static *** d(...);
    public static *** v(...);
    public static *** i(...);
}

# 保持 Native 方法
-keepclasseswithmembernames class * {
    native <methods>;
}

# 保持枚举
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# 保持 Parcelable
-keep class * implements android.os.Parcelable {
  public static final android.os.Parcelable$Creator *;
}

# 保持 Serializable
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}
