# collaboration is no longer actively maintained by VMware, Inc.

## Status

Development **In Progress**

Travis CI : [![Build Status](https://secure.travis-ci.org/ciberch/collaboration.png)](http://travis-ci.org/ciberch/collaboration)

## Overview

This is a sample RoR application which demonstrates how to connect with popular social networks to share your work as a developer
and get help and feedback from other developers. It currently works with Facebook and Cloud Foundry Proxy (OAUth 2.0 proxy for api.cloudfoundry.com)

## Getting Started

* Clone the repository
* Install MySQL
* use RVM to target Ruby 1.9.2
* Run `bundle install`
* run `rake db:create:all`
* run `rake db:migrate`
* run `rails s`
* Install MongoDB
* run `rake db:mongoid:create_indexes`

Add environment variables for your keys, tokens and services

### Example
- facebook_app_id              => 134346231793434                     
- facebook_app_secret          => ca34o3i4ijr43n3irj39346561a214a3
- facebook_login_options       => email
- cloudfoundry_auth_server     => https://dsyerauth.cloudfoundry.com/ 
- cloudfoundry_client_id       => iririiroerieorieo                   
- cloudfoundry_client_secret   => 83848348384838483                   
- cloudfoundry_resource_server => https://dsyerapi.cloudfoundry.com/
- github_client_id             => a6e29d232e9081635797
- github_client_secret         => c1c4037a92weebdf4bdf27b791284a30aaa0a41e


## Testing

* run `spork` to start the test server
* run `bundle exec rake` to execute the tests

## Deploying on Cloud Foundry or Micro Cloud Foundry

```
$ vmc push --runtime ruby19
Would you like to deploy from the current directory? [Yn]: Y
Application Name: apps
Application Deployed URL: 'apps.monica.cloudfoundry.me'?
Detected a Rails Application, is this correct? [Yn]: Y
Memory Reservation [Default:256M] (64M, 128M, 256M or 512M)
Creating Application: OK
Would you like to bind any services to 'apps'? [yN]: Y
The following system services are available:
1. mongodb
2. mysql
3. postgresql
4. rabbitmq
5. redis
Please select one you wish to provision: 2
Specify the name of the service [mysql-19892]: collaboration
Creating Service: OK
Binding Service: OK
Uploading Application:
  Checking for available resources: OK
  Processing resources: OK
  Packing application: OK
  Uploading (6M): OK
Push Status: OK
Staging Application: OK
Starting Application: ......................... OK
```

### Bind the MongoDB service

```
$ vmc create-service mongodb mongo1 apps
Creating Service: OK
Binding Service: OK
Stopping Application: OK
Staging Application: OK
Starting Application: ..........................OK
```


### Add all the environment variables

Example of how to add one:

```
$ vmc env-add apps facebook_app_id=134346231793434
```

## Licensing
Copyright 2010-2011, VMware, Inc. Licensed under the Apache Version 2.0 license, please see the LICENSE file. All rights reserved.
http://www.apache.org/licenses/LICENSE-2.0.html


