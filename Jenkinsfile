pipeline {
    agent any
    tools {
        terraform 'terraform'
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
        // stage('checkout') {
        //     steps {
        //          script{
        //                 dir("terraform")
        //                 {
        //                     git "https://github.com/DhruvRana1995/test-jenkins-public-repo.git"
        //                 }
        //             }
        //         }
        //     }

        stage('Plan') {
            when {
                not {
                    equals expected: true, actual: params.destroy
                }
            }
            
            steps {
                dir("infra"){
                    sh 'ls -ls'
                    sh 'pwd'
                    sh 'whoami'
                    sh 'which git'
                    // sh 'which terraform'
                    sh 'terraform --version'


                    sh 'terraform init'
    //                 sh 'terraform workspace select ${environment} || terraform workspace new ${environment}'

                    sh 'terraform plan -var="app_image=nginx" -var="app_port=80"'
                }

            }
        }
//         stage('Approval') {
//            when {
//                not {
//                    equals expected: true, actual: params.autoApprove
//                }
//                not {
//                     equals expected: true, actual: params.destroy
//                 }
//            }
           
                
            

//            steps {
//                script {
//                     def plan = readFile 'tfplan.txt'
//                     input message: "Do you want to apply the plan?",
//                     parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
//                }
//            }
//        }

//         stage('Apply') {
//             when {
//                 not {
//                     equals expected: true, actual: params.destroy
//                 }
//             }
            
//             steps {
//                 sh 'cd infra/'
//                 sh "terraform apply -input=false tfplan"
//             }
//         }
        
//         stage('Destroy') {
//             when {
//                 equals expected: true, actual: params.destroy
//             }
        
//         steps {
//            sh 'cd infra/'
//            sh "terraform destroy --auto-approve"
//         }
//     }

  }
}
