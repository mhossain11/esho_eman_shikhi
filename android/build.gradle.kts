buildscript {
    // Align Kotlin to 2.1.0 for toolchain consistency with Java 21
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        // Android Gradle Plugin 8.12.0 for SDK 36 and 16KB page support
        classpath("com.android.tools.build:gradle:8.12.0")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
