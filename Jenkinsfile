pipeline
{
agent any
stages
{
stage('scm-checkout')
{
steps
{
git branch: 'master', url: 'https://github.com/Jaynath1992/DjangoSampleApp.git'
}
}
stage('Build pyton based docker image and install all dependencies')
{
  steps
        {
          sh 'docker build -t jaynath120/jaynath-django-app:1.0.0 .'
        }
}

stage ('Push Docker image to DockerHub') 
{
	steps
	{
		   withCredentials([string(credentialsId: 'dockerhubaccount1', variable: 'dockerhubaccount1')]) {
			   sh "docker login -u jaynath120 -p ${dockerhubaccount1}"
		     }
		    sh 'docker push jaynath120/jaynath-django-app:1.0.0'
	}
	
 }

stage ('Deploy to Dev environment') 
{
	steps
	{
		script
		{
			      def dockerRun = 'docker run -d -p 8000:8000 --name my-django-app jaynath120/jaynath-django-app:1.0.0'
			      sshagent(['deploy-to-dev-docker']) {
				  sh "ssh -o StrictHostKeyChecking=no ec2-user@3.133.110.85 ${dockerRun}"
			      }
		}
	}
 }


}
}
