pipeline {
    agent { label 'jdk8_maven' }
    parameters { choice(name: 'Maven_Goals', choices: ['package', 'install', 'validate'], description: 'Maven Goals') }
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
                sh "mvn ${params.Maven_Goals}"
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