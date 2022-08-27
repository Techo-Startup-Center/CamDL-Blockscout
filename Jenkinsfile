pipeline{
    agent any
    stages {
        stage("Build and tag image") {
            steps {
                script {
                    docker.build("registry.camdx.gov.kh/camdl/blockscout:v4.1.7-$BUILD_NUMBER-beta","./docker")
                }
            }
        }
        stage('Deploy Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.camdx.gov.kh', 'harbor-credential') {
                        sh "docker push registry.camdx.gov.kh/camdl/blockscout:v4.1.7-$BUILD_NUMBER-beta"
                    }
                }
                
            }
        }
    }

    post {
        always {
            cleanWs()
            sh "docker image rm -f registry.camdx.gov.kh/camdl/blockscout:v4.1.7-$BUILD_NUMBER-beta"
        }
    }
}