node('jdk8_maven') {
    stage('VCS') {
        git url: 'https://github.com/My-DevOps-Notes-Examples/game-of-life.git',
            branch: 'scripted'
    }
    stage('Build') {
        sh 'export PATH="/usr/lib/jvm/java-8-openjdk-amd64/bin:$PATH" && mvn package'
    }
}