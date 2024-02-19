pipeline {
    agent { label 'jdk8_maven' }
    parameters { string(name: 'Maven_Goal', defaultValue: 'package', description: 'This is the Maven Goal') }
    triggers { pollSCM('* * * * *') }
    tools { jdk 'jdk_8' }
    stages {
        stage('VCS') {
            steps {
                git url: 'https://github.com/My-DevOps-Notes-Examples/game-of-life.git',
                    branch: 'declarative'
            }
        }
        stage('Build') {
            steps {
                sh "mvn ${params.Maven_Goal}"
            }
        }
        stage('Post-Build') {
            steps {
                archiveArtifacts artifacts: '**/target/*.war',
                         allowEmptyArchive: false,
                         onlyIfSuccessful: true
                junit testResults: '**/surefire-reports/TEST-*.xml',
                      allowEmptyResults: false
            }
        }
    }
}