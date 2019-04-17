# Readme

Simple ruby scirpt for checking HTTP response of passed url.

### Usage
Just run it with: 

```sh
$ git clone https://github.com/oleg-cnnr/artec3d-test.git
$ cd artec3d-test
$ ruby monitoring.rb URL EMAIL|PHONE
```
where 
- URL is fully qualified url,
- EMAIL is a fully qualified email address,
- PHONE could be anything else, but will be used as a recipient mobile phone number

Also you should copy `.env.example` to `.env` and set your actual SMTP settings there.

PS

I see my mistake with incorrect countdown without difference with past time, but I hope you'll be fair with me.
