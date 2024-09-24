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
Now, I'll need to 