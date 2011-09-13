## Status

Development **In Progress**

Travis CI : [![Build Status](https://secure.travis-ci.org/ciberch/collaboration.png)](http://travis-ci.org/ciberch/collaboration)

## Overview

Collaboration is Proof of Concept project which will be used as the predecessor to a "collaborate" gem.

The project demonstrates how we can model permissions to resources in such a way that teams of any size can have as
fine grained control to their resources as they need.

This design was created by Dale Olds with participation of the Cloud Foundry team.

The main question being answered is whether a user can perform an action on a resource.
Typically in most rails applications default to basic roles whether the user is an admin or not.
Or check whether the user is the owner of the given resource.
This design moves away from validating access based on individual ownership as members are considered transient.

## Getting Started

- Clone the repository
- Install MySQL
- use RVM to target Ruby 1.9.2
- Run `bundle install`
- run `rake db:create:all`
- run `rake db:migrate`
- run `rails s`

## Testing
- run `spork` to start the test server
- run `bundle exec rake` to execute the tests


