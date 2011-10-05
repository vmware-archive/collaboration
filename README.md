## Status

Development **In Progress**

Travis CI : [![Build Status](https://secure.travis-ci.org/ciberch/collaboration.png)](http://travis-ci.org/ciberch/collaboration)

## Overview

This is a sample RoR application which demonstrates how to connect with popular social networks to share your work as a developer
and get help and feedback from other developers. It currently works with Facebook and Cloud Foundry Proxy (OAUth 2.0 proxy for api.cloudfoundry.com)

## Getting Started

- Clone the repository
- Install MySQL
- use RVM to target Ruby 1.9.2
- Run `bundle install`
- run `rake db:create:all`
- run `rake db:migrate`
- run `rails s`

- Install MongoDB
- run `rake db:mongoid:create_indexes`

Add environment variables for your keys, tokens and services

### Example

- facebook_app_id              => 134346231793434                     
- facebook_app_secret          => ca34o3i4ijr43n3irj39346561a214a3    
- cloudfoundry_auth_server     => https://dsyerauth.cloudfoundry.com/ 
- cloudfoundry_client_id       => iririiroerieorieo                   
- cloudfoundry_client_secret   => 83848348384838483                   
- cloudfoundry_resource_server => https://dsyerapi.cloudfoundry.com/  


## Testing
- run `spork` to start the test server
- run `bundle exec rake` to execute the tests

## Licensing
Copyright 2010-2011, VMware, Inc. Licensed under the Apache Version 2.0 license, please see the LICENSE file. All rights reserved.
http://www.apache.org/licenses/LICENSE-2.0.html


