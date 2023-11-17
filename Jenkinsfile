pipeline {
        agent any
        environment {
            PROJECT_ID = 'jenkins'
            CLUSTER_NAME = 'my-cluster'
            LOCATION = 'usa'
            CREDENTIALS_ID = 'kubeconfig'
        }
    stages {
        stage("Checkout code") {
            steps {
                checkout scm
            }
        }
        stage("Build image") {
            steps {
                script {
                    myapp = docker.build("example-user/node-app:${env.BUILD_ID}")
                }
            }
        }
        stage("Push image") {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-credential') {
                            myapp.push("latest")
                            myapp.push("${env.BUILD_ID}")
                    }
                }
            }
        }
      stage("Deploy to Vultr Kubernetes") {
         steps {
            sh "sed -i 's/node-app:latest/node-app:${env.BUILD_ID}/g' deployment.yml"
                script {
       withKubeConfig([credentialsId: 'kubeconfig']) 
        {
          sh 'kubectl get nodes'
          sh "kubectl apply -f deployment.yml"
          sh "kubectl apply -f service.yml"

     }                
    }
   }
  }    
 }
}
