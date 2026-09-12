import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("environment")

    productFlavors {
        create("dev") {
            dimension = "environment"
            applicationId = "com.multibook.app.dev"
            manifestPlaceholders["googleMapsApiKey"] = project.extra["devGoogleMapsApiKey"] as String
            resValue(type = "string", name = "app_name", value = "MultiBook DEV")
        }
        create("prod") {
            dimension = "environment"
            applicationId = "com.multibook.app"
            manifestPlaceholders["googleMapsApiKey"] = project.extra["prodGoogleMapsApiKey"] as String
            resValue(type = "string", name = "app_name", value = "MultiBook")
        }
    }

    buildFeatures.resValues = true
}