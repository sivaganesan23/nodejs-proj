node('SLAVE2') {
stage('CLONE') {
 dir('APPCODE') {
   git 'https://github.com/opsworkshop/node-hello.git' 
    }
   }

 stage('ENV-CREATE') {
    withCredentials([file(credentialsId: 'CENTOS-USER-PEM-FILE', variable: 'FILE')]) {
    sh '''sudo cat $FILE >/home/centos/devops.pem
      sudo chmod 600 /home/centos/devops.pem
     '''
    }
   dir('TERRAFORM') {
     git 'https://github.com/sivaganesan23/nodejs-proj.git'
      wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'xterm']) {
      withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'AWS-USER-KEYS', usernameVariable: 'ACCESS_KEY', passwordVariable: 'SECRET_KEY']]) {
      sh '''
      export AWS_ACCESS_KEY_ID=$ACCESS_KEY
      export AWS_SECRET_ACCESS_KEY=$SECRET_KEY
      export AWS_DEFAULT_REGION=us-east-2     
      cd terraform
      terraform init
      terraform apply -auto-approve
      '''
              }
          }
          }
 }
}
