#!/usr/bin/env groovy

pipeline {
  agent { label 'executor-v2' }

  options {
    timestamps()
    buildDiscarder(logRotator(numToKeepStr: '30'))
  }

  triggers {
    cron(getDailyCronString())
  }

  stages {
    stage('Test') {
      steps { sh './test.sh' }
    }

    // Only publish to RubyGems if branch is 'master'
    // AND someone confirms this stage within 5 minutes

    stage('Publish to RubyGems') {
      when {
        allOf {
          branch 'master'
          expression {
            boolean publish = false

            if (env.PUBLISH_GEM == "true") {
                return true
            }

            try {
              timeout(time: 5, unit: 'MINUTES') {
                input(message: 'Publish to RubyGems?')
                publish = true
              }
            } catch (final ignore) {
              publish = false
            }

            return publish
          }
        }
      }
      steps {
        script {
        // Clean up first
        
        sh 'docker run -i --rm -v $PWD:/src -w /src --entrypoint /bin/sh alpine/git \
            -c "git config --global --add safe.directory /src && \
            git clean -fxd" '

        sh './publish.sh'

        // Clean up again...
        sh 'docker run -i --rm -v $PWD:/src -w /src --entrypoint /bin/sh alpine/git \
            -c "git config --global --add safe.directory /src && \
            git clean -fxd" '

        
        } 
      } 
    } 
  } 

  post {
    always {
      cleanupAndNotify(currentBuild.currentResult)
    }
  }
}
