pipeline {
    agent { label 'Jdk17_Maven' }
    triggers { pollSCM('* * * * *') }
    tools { jdk 'Jdk8' }
    stages {
        stage('VCS') {
            steps {
                git url: 'https://github.com/My-DevOps-Notes-Examples/game-of-life.git',
                    branch: 'declarative'
            }
        }
        stage('Build') {
            steps {
                sh "mvn package"
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