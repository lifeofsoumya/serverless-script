#!/bin/bash

npm install -g serverless

mkdir slssvs
cd slssvs

echo 'exports.handler = async (event) => {
  const requestBody = JSON.parse(event.body);

  if (!requestBody.email) {
    return {
      statusCode: 400,
      body: JSON.stringify({ message: 'Email is required in the payload' }),
    };
  }

  const { email } = requestBody;

  const response = {
    statusCode: 200,
    body: JSON.stringify({ message: `Received email: ${email}` }),
  };

  return response;
};' > postFunction.js

echo 'exports.handler = async (event) => {
  const response = {
    statusCode: 200,
    body: JSON.stringify("This is the GET function response."),
  };
  return response;
};' > getFunction.js


echo 'service: sam-serverless

provider:
  name: aws
  runtime: nodejs18.x

functions:
  postFunction:
    handler: postFunction.handler

  getFunction:
    handler: getFunction.handler' > serverless.yml


./aws_cred.sh

serverless deploy
