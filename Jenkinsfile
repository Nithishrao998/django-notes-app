@Library("Shared") _
pipeline {
    agent { label "goutham" }

    stages {
        stage("hello"){
            steps{
                script{
                    hello()
                }
            }
        }
        
        stage("code") {
            steps {
                script{
                clone("https://github.com/Nithishrao998/django-notes-app.git","main")
                }
            }
        }

        stage("build") {
            steps {
                script{
                docker_build("notes-app","latest","nithishrao")
            }
            }
        }

        stage("push") {
            steps {
               script{
                    docker_push("notes-app", "latest", "nithishrao")
               }
            }
        }

        stage("deploy") {
            steps {
                echo "this is deploying the code"
                sh "docker compose up -d"
            }
        }
    }
}
