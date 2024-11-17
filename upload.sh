#!/bin/bash

# Configuration
DIRECTORY="C:\Users\ander\Documents\RENIEC\TESTS\code-with-quarkus\code-with-quarkus\target\alternateLocation"  # Directory containing JAR files
NEXUS_URL="http://localhost:8081/repository/maven-releases/"  # Nexus repository URL
USERNAME="admin"  # Nexus username
PASSWORD="CONTRASEÑA"  # Nexus password

# Maven coordinates
GROUP_ID="com.reniec"  # Replace with your actual groupId

# Loop through all JAR files in the specified directory
for jar in "$DIRECTORY"/*.jar; do
    if [ -f "$jar" ]; then
        echo "Uploading $jar to Nexus..."

        # Extract the filename without the path
        filename=$(basename "$jar")

        # Remove the .jar extension to get the artifact info
        artifact_info="${filename%.jar}"

        # Extract artifactId and version
        # Split by the last '-' to separate artifactId and version
        version="${artifact_info##*-}"  # Get version (last part)
        artifact_id="${artifact_info%-*}"  # Get everything before the last '-'

        # Handle multiple '-' in artifactId by replacing them with '.'
        artifact_id="${artifact_id//-/.}"

        # Construct the upload URL
        upload_url="$NEXUS_URL${GROUP_ID//.//}/$artifact_id/$version/$artifact_id-$version.jar"

        # Check if version is empty
        if [ -z "$version" ]; then
            echo "Error: Version is empty for $filename."
            continue
        fi
        
        # Upload JAR to Nexus
        curl -u "$USERNAME:$PASSWORD" --upload-file "$jar" "$upload_url"

        if [ $? -eq 0 ]; then
            echo "Successfully uploaded $artifact_id version $version."
        else
            echo "Failed to upload $artifact_id version $version."
        fi
    else
        echo "No JAR files found in the directory."
    fi
done