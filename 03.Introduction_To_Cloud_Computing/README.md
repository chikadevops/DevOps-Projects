# Introduction to Cloud Computing

## In this project, i'll be demonstrating how to deploy a website using Git for version control, Linux environment to develop the platform, and deploy on an AWS EC2 instance. I'll also uses a sample website template.

## Version Control Implementation with Git

First thing to do is initialize my git repository by creating a project directory named "MarketPeak_Ecommerce" on my local machine, using the following commands:

```
mkdir MarketPeak_Ecommerce
cd MarketPeak_Ecommerce
git init
```
![](./img/img%201.png)


Next thing I did was to obtain and prepare the website template. I downloaded it and extracted the files into my previously created project directory, ***MarketPeak_Ecommerce***.
![](./img/img%202.png)

Next, I statged and commited the template to Git using:
```
git add .
git config --global user.name "MyUsername"
git config --global user.email "myemail@example.com"
git commit -m "Initial commit with basic e-commerce site structure"
```
![](./img/img%203.png)

The next thing to do is to push my code to my remote repo. Since the repo was initially created in my local machine, I had to link my local repo to Github.<br> So I created a remote repository on Github and name it ***MarketPeak_Ecommerce*** and left the repository empty without initializing it with a README, .gitignore, or a licence file in order to avoid conflict in both repos.<br> I used theh following code to link my local repo to Github.<br>
`git remote add origin https://github.com/my-git-username/MarketPeak_Ecommerce.git`<br>
Then I pushed my code using `git push -u origin main`

![](./img/img%204.png)

## AWS Deployment
Now, I'll need to login to AWS Management Console, launch an EC2 instance using Amazon Linux AMI and connect to the instance using SSH.
![](./img/img%206.png)
![](./img/img%207.png)


Next, I cloned the repository on the linx server using ***HTTPS*** with the following command:<br>
`git clone https://github.com/myusername/MarketPeak_Ecommerce.git`

Next was to install a Web Server on EC2.
***Apache HTTP Server (httpd)*** is a widely used web server that serves HTML files and content over the internet. Installing it on Linxus EC2 server allowed me to host my ***MarketPeak E-Commerce*** site.

First thing was to install apache web server on my EC2 instance using the following commands:
```sudo yum update -y
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
```
![](./img/img%209.png)
The first updates the linux server and then installs httpd (Apache), starts the web server, and ensures it automatically starts on sever boot.

Next thing to do was to configure httpd to point to the directory on the linx server here the website code files are stored. Usually in ***/var/www/html***. So I had to delete the existing directory and all the files in it, and copied my MarketPeak Ecommerce website files in it, using the commands below.
```
sudo rm -rf /var/www/html/*
sudo cp -r ~/MarketPeak_Ecommerce/* /var/www/html/
```
Then I reloaded httpd to apply changes using `sudo systemctl reload httpd`

I used `sudo systemctl status httpd` to check if the server was up and running.
![](./img/img%2010.png)

Next thing I did was to access the website from a browser using the public IP of my EC2 instance.
![](./img/img%2011.png)

## Continious Integration and Deployment Workflow

I needed to develop new features and do some bug fixes so created a new branch named "development" and checked into the new branch with the commands below.
```
git branch development
git checkout development
```
![](./img/img%2012.png)

Next, I stated, commited and pushed my changes. The push command was slightly different because I was working on a different branch that waasn't yet updated on Github so I used<br> `git push origin development`
![](./img/img%2013.png)

Next, I need to merge my development branch to the Main branch so I created a Pull Request on Github. I reviewed the changes and once I was satisfied, I merged the pull request in to the manbranch using ```
git checkout main
git merge development```

Then I pushed code to main uisng `git push origin main` and restarted the webserver to apply changes using `sudo systemctl reload httpd`.

#Thank you




