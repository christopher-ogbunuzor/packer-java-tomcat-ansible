# USER GUIDE

## Commands 
- convert `packer-build.json` to `hcl2`

```
packer hcl2_upgrade -with-annotations packer-build.json
chmod +x ./provisioners/scripts/bootstrap.sh

```
## How to download WAR Archive for java application

The `WAR` file was downloaded using the below steps

cd into `files` folder

`wget https://tomcat.apache.org/tomcat-9.0-doc/appdev/sample/sample.war`

## More information

see this [link](https://computingforgeeks.com/build-aws-ec2-machine-images-with-packer-and-ansible/?expand_article=1#google_vignette)

## Successful deployment verification
- If deployment is successful, you should see the image below

![Tomcat](Static/Image/tomcat.png)

