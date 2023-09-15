# USER GUIDE

## Commands 
convert `packer-build.json` to `hcl2`

```
packer hcl2_upgrade -with-annotations packer-build.json
chmod +x ./provisioners/scripts/bootstrap.sh

```
## How to download WAR Archive for java application

The `WAR` file was downloaded using the below steps

- cd into `files` folder
- Run the `wget` command below

```
wget https://tomcat.apache.org/tomcat-9.0-doc/appdev/sample/sample.war

```
## More information

see this [link](https://computingforgeeks.com/build-aws-ec2-machine-images-with-packer-and-ansible/?expand_article=1#google_vignette)


## Successful deployment verification
- Launch EC2 using the packer AMI
- Open `port 8080`, `custom tcp` protocol on the security group
- Access page on browser using
    `http://ec2_public_ip:8080`
- If deployment is successful, you should see the image below

![Tomcat](Static/Image/tomcat.png)

