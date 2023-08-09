versionSaveCommand="gradle setVersion -P"

versionSetCommand=$(cat << 'EOF'
                  task sourcesJar(type: Jar) {
                      from sourceSets.main.allSource
                      archiveClassifier.set('sources')
                  }

                  task javadocJar(type: Jar, dependsOn: 'javadoc') {
                      from javadoc.destinationDir
                      archiveClassifier.set('javadoc')
                  }

                  task setVersion {
                      doLast {
                          if (project.hasProperty("newVersion")) {
                              project.version = newVersion
                          }
                      }
                  }
                  EOF
                  )

versionSetCommand="eval echo '\n\n$versionSetCommand' >> build.gradle"


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