# credentials

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with credentials](#setup)
    * [What credentials affects](#what-credentials-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with credentials](#beginning-with-credentials)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

Simple module to manage credential files in user home directories.

## Setup

### Beginning with credentials

Follow [this page](https://docs.puppet.com/puppet/latest/reference/lookup_quick_module.html) to setup your puppet server for data in modules.

Depending on how your setup is, you can now use:

`include '::credentials'` 

from anywhere.

```puppet
class { '::credentials':
  users => { ... },
}
```
from profile and roles.

Or add the class 'credentials' to you 'classes' array, if you use
```puppet
hiera_include('classes')
```
or
```puppet
lookup('classes', {merge => unique}).include
```

Specifying credentials will be done in hiera. An example:
```puppet
credentials::users:
  rbe:
    vault:
      ensure : 'file'
      path : '.vault-token'
      content : 'xxxxxxxx-1234-abcd-yyyyyyyy'
  user1:
    secret:
      ensure : 'file'
      path : '.secret-content-token'
      content : '12345678-abcd-efgh-09876543'
```

This will create two files: 1) '/home/rbe/.vault-token' with above content and permission '0440' and 'root:rbe'. 2) '/home/user1/.secret-content-token' with above content and permissions '0440' and 'root:user1'.

##Usage

All interaction with the credentials module can be done through the main credentials class. This means you can simply toggle the options in `::credentials` to have full functionality of the module.
