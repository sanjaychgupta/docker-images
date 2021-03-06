# docker-git-server-centos

Docker image for git-server-centos on CentOS

## Requirement 
* Docker Desktop should be installed on your machine
  * [Docker Desktop for Windows](https://hub.docker.com/editions/community/docker-ce-desktop-windows)
  * [Docker Desktop for Mac](https://hub.docker.com/editions/community/docker-ce-desktop-mac)

## Build

To create the image `sanjay420/git-server-centos`, execute the following command inside` git-server-centos` folder:

    docker build --rm -t sanjay420/git-server-centos .
  
## Run

To run the image with a minimum of arguments, execute the following command :

    docker run -d  --privileged  -v /path/to/map/:/home/git -p 22:22 sanjay420/git-server-centos
  **NOTE:-** If you encounter problem that port 22 is not free on your host then check **Port section** 

## Arguments

#### Volumes

* **/home/git**: In this volume you can secure your remote git repositories and authorized ssh key once created/added. This will ensure if container comes to problem where you need to remove and run it container again your remote git repositories and authorized ssh key will be safe and backed up.

#### Ports
* Port used here 22 which is default for SSH but, incase if your required to use different and reason may be like 22 port on your host is not available than you can map `-p <Available port> : 22` during `docker run`

**Note:-** while doing ssh also use -p <Available port\>

## Git usage

### Authorized keys : 
To add an authorized ssh key, you have to add it to `/home/git/.ssh/authorized_keys` 
  * Generate SSH key on your Host Machine([Windows](https://www.ssh.com/ssh/putty/windows/puttygen)).
  * Generate SSH key on your Host Machine([Mac](https://docs.joyent.com/public-cloud/getting-started/ssh-keys/generating-an-ssh-key-manually/manually-generating-your-ssh-key-in-mac-os-x))
  * With the help of below command copy it to your container.

          cat ~/.ssh/id_rsa.pub | ssh -p 8022 git@localhost "mkdir -p ~/.ssh && cat >>  ~/.ssh/authorized_keys"
    **Note:-** Frst time password is required for git user and password=git and please change password for security reason.

### How to create repository on git server.
  * Using ` create-repository repo-name` command
    
        create-repository <your-repo-name>
      Alternately,

        mkdir /home/git/<your-repo-name>.git
        cd /home/git/<your-repo-name>.git
        git init --bare
        chown -R git:git /home/git/<your-repo-name>.git
### How to delete repository on git server.
  * Using ` delete-repository repo-name` command
    
        delete-repository <your-repo-name>
      Alternately 
            
        rm -rf /home/git/<your-repo-name>.git

### How to add your project which is not present git server.

      cd <your project folder>
      git init
      git add .
      git commit -m "Initial commit"
      git remote add origin ssh:/git@localhost/home/git<your-repo-name>.git
          OR if using port other than 22 i.e 8022
      git remote add origin ssh:/git@localhost:8022/home/git/<your-repo-name>.git
  
### How to clone repository from git server

      ssh://git@localhost/home/git/<your-repo-name>.git
          OR if using port other than 22 i.e 8022
      ssh://git@localhost:8022/home/git/$<your-repo-name>.git
       