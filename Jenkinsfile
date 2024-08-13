pipeline {
        agent {label 'mvn_jdk8&17' }
        tools { jdk 'jdk_8' }
        stages {
            stage('VCS') {
                steps {
                    git url: 'https://github.com/My-DevOps-Notes-Examples/game-of-life.git',
                        branch: 'master'
                }
            }
            stage('Build') {
                steps {
                    sh 'mvn package'
                }
            }
            stage('Post-Build') {
                steps {
                    archiveArtifacts artifacts: '**/target/*.war',
                                     allowEmptyArchive: false,
                                     onlyIfSuccessful: true
                    junit testResults: '**/surefire-reports/TEST-*.xml',
                          allowEmptyResults: false
                    stash name: 'deploy_file',
                          includes: '**/target/*.war, Dockerfile'
                }
            }
            stage('Unarchive-Files') {
                agent { label 'docker' }
                steps {
                    unstash name: 'deploy_file'
                }
            }
            stage('Deploy') {
                agent { label 'docker' }
                steps {
                    sh 'docker image build -t tomcat:gol-${buildNumber} /home/ubuntu/workspace/Game-of-Life/.'
                    sh 'docker container run -d --name gol-${buildNumber} -P tomcat:gol-${buildNumber}'
                }
            }
        }
    }
