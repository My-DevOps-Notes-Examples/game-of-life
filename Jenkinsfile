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
        stage('Artifactory configuration') {
            steps {
                rtServer (
                    id: "ARTIFACTORY",
                    url: 'https://sureshk.jfrog.io/artifactory',
                    credentialsId: 'JfrogCloud'
                )

                rtMavenDeployer (
                    id: "MAVEN_DEPLOYER",
                    serverId: "ARTIFACTORY",
                    releaseRepo: 'gameoflife-libs-release',
                    snapshotRepo: 'gameoflife-libs-snapshot'
                )

                rtMavenResolver (
                    id: "MAVEN_RESOLVER",
                    serverId: "ARTIFACTORY",
                    releaseRepo: 'gameoflife-libs-release',
                    snapshotRepo: 'gameoflife-libs-snapshot'
                )
            }
        }

        stage('Exec Maven') {
            steps {
                rtMavenRun (
                    tool: 'Default_Maven', // Tool name from Jenkins configuration
                    pom: 'pom.xml',
                    goals: 'clean install',
                    deployerId: "MAVEN_DEPLOYER",
                    resolverId: "MAVEN_RESOLVER"
                )
            }
        }
        stage('Post-Build') {
            steps {
                archiveArtifacts artifacts: '**/target/*.war',
                         allowEmptyArchive: false,
                         onlyIfSuccessful: true
                junit testResults: '**/surefire-reports/TEST-*.xml',
                      allowEmptyResults: false
                rtPublishBuildInfo (
                    serverId: "ARTIFACTORY"
                )
                stash name: 'gol_war_file',
                      includes: '**/target/gameoflife.war'
            }
        }
        stage('Unstash') {
            agent { label 'StoreData' }
            steps {
                unstash name: 'gol_war_file'
            }
        }
    }
}