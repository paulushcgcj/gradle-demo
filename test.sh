# Sets the initial names as maven by default
versionSetCommand="eval echo '\n\ntask setVersion { doLast { if (project.hasProperty(\"newVersion\")) { project.version = newVersion } } }' >> build.gradle"
versionSaveCommand="gradle setVersion -P"

# Process extra arguments to add sources and javadoc
#if [ ${{ inputs.add-sources }} == "true" ]; then
#    addSources="-DaddSources=true"
#else
#    addSources=""
#fi
#if [ ${{ inputs.add-javadoc }} == "true" ]; then
#    addJavadoc="-DaddJavadoc=true"
#else
#    addJavadoc=""
#fi
gradle clean

new_version="$1"
${versionSetCommand}
gradle setVersion build -PnewVersion=${new_version}

git reset --hard