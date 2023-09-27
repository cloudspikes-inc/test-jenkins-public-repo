pipeline {
    agent any
    tools {
        terraform 'Terraform'
    }

    parameters {
        string(name: 'environment', defaultValue: 'terraform', description: 'Workspace/environment file to use for deployment')
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
        booleanParam(name: 'destroy', defaultValue: false, description: 'Destroy Terraform build?')
    }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }


    stages {
//      #1
        stage('Plan') {
            when {
                not {
                    equals expected: true, actual: params.destroy
                }
            }
            
            steps {
                dir("infra"){
                    sh 'ls -la'
                    sh 'pwd'
                    sh 'whoami'
                    sh 'which git'
                    
                    sh 'terraform --version'
                    sh 'aws --version'

                    sh 'terraform init'
                    sh 'terraform fmt'
                    sh 'terraform validate'

                    sh 'terraform plan -var="app_image=nginx" -var="app_port=80"'
                }

            }
        }

//      #2
        stage('Approval') {
           when {
               not {
                   equals expected: true, actual: params.autoApprove
               }
               not {
                    equals expected: true, actual: params.destroy
                }
           }

           steps {
               script {
                    // def plan = readFile 'tfplan.txt'
                    input message: "Do you want to apply the plan?",
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: 'Check pipeline logs for terraform plan.')]
               }
           }
        }

//      #3
        stage('Apply') {
            when {
                not {
                    equals expected: true, actual: params.destroy
                }
            }
            
            steps {
                dir("infra"){
                    sh 'terraform apply  -var="app_image=nginx" -var="app_port=80" --auto-approve'
                }
            }
        }
        
//      #4        
        stage('Destroy') {
            when {
                equals expected: true, actual: params.destroy
            }
        
            steps {   
                dir("infra"){
                    sh 'terraform destroy  -var="app_image=nginx" -var="app_port=80" --auto-approve'
                }
            }
        }

    }
}
