allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

subprojects {
    val configureAction = Action<Project> {
        if (plugins.hasPlugin("com.android.library")) {
            val androidExt = extensions.findByType(com.android.build.gradle.LibraryExtension::class.java)
            if (androidExt != null && androidExt.namespace == null) {
                androidExt.namespace = "com.pixelcanvas.plugin.${name.replace("-", "_")}"
            }
        }
    }
    if (state.executed) {
        configureAction.execute(this)
    } else {
        afterEvaluate(configureAction)
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
