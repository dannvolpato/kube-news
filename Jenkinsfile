pipeline {
    agent any

    stages {
        stage("build docker image") {
            steps {
                script {
                    dockerapp = docker.build("dvolpato/kube-news:${env.BUILD_ID}")
                }
            }
        }

        stage("push docker image") {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                        dockerapp.push('latest')
                        dockerapp.push("${env.BUILD_ID}")
                    }
                }
            }
        }

        stage ("deploy kubernetes") {
            environment {
                tag_version = "${env.BUILD_ID}"
            }
            steps {
                script {
                    withKubeConfig([credentialsId: 'kubeconfig']) {
                        sh 'sed -i "s/{{TAG}}/$tag_version/g" ./k8s/deployment.yml'
                        sh 'kubectl apply -f ./k8s/deployment.yml'
                    }
                }
            }
        }
    }
}