pipeline {
  environment {
    registry = "devhodi/docker-home-test"
    registryCredential = 'docker_hub'
    dockerImage = ''
    TF_WORKSPACE = 'dev' //Sets the Terraform Workspace
    TF_IN_AUTOMATION = 'true'
    AWS_ACCESS_KEY_ID = "${params.AWS_ACCESS_KEY_ID}"
    AWS_SECRET_ACCESS_KEY = "${params.AWS_SECRET_ACCESS_KEY}"
  }
  // parameters {
  //   password (name: 'AWS_ACCESS_KEY_ID')
  //   password (name: 'AWS_SECRET_ACCESS_KEY')
  // }``
  agent any
  options {buildDiscarder(logRotator(daysToKeepStr: '5', numToKeepStr: '20'))}
  stages {
    stage('Cloning Git') {
      steps {
        script {
            properties([pipelineTriggers([pollSCM('30 * * * *')])])
        }
        git 'https://github.com/hodayaYProject/home_test.git'
      }
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Push Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        bat "docker rmi $registry:$BUILD_NUMBER"
      }
    }
  }
  
  // stages {
  //   stage('Terraform Init') {
  //     steps {
  //       sh "${env.TERRAFORM_HOME}/terraform init -input=false"
  //     }
  //   }
  //   stage('Terraform Plan') {
  //     steps {
  //       sh "${env.TERRAFORM_HOME}/terraform plan -out=tfplan -input=false -var-file='dev.tfvars'"
  //     }
  //   }
  //   stage('Terraform Apply') {
  //     steps {
  //       input 'Apply Plan'
  //       sh "${env.TERRAFORM_HOME}/terraform apply -input=false tfplan"
  //     }
  //   }
  //   stage('AWSpec Tests') {
  //     steps {
  //         sh '''#!/bin/bash -l
  //         bundle install --path ~/.gem
  //         bundle exec rake spec || true
  //         '''
  //       junit(allowEmptyResults: true, testResults: '**/testResults/*.xml')
  //     }
  //   }
  // }
}