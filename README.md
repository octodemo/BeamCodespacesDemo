# Blazor Beams Demo Guide
Application Description: A Pun-centric application that looks a lot like a combination between Twitter and Reddit with a little Slack.
The user can "Beam Rays" (Messages) on "Frequencies".  A user can "prism" those rays so that they are more visible.

The Blazor beams demo application is an automatically provisioned demo application for demoing Codespaces.  It has a Blazor web front end, .NET Core middle tier, and SQL Server backend.
- Blazor WebAssembly Client
- Hosted in ASP.Net Core, with a Web API backend
- SQL Server Database
- EF Core database access
- .NET 6


----
## Standard Demo
This demo covers launching and using a Codespace. You will review the .devcontainer files, container configuration, etc.  

#### steps
1. Create Codespace from `< > Code` tab in repo. Select `Configure & Create Codespace` from dropdown. On Configuration, talk through the config options. Optionally change things, or just click `Create Codespace`.
2. The Codespace should start in the browser window. Mention this capability, then switch to local VS Code (or IntelliJ IDE, if you're in the alpha).

  > 🎤 **Talk track:** Flexibility of working from anywhere, ie an iPad in the browser, but you can also work locally, which devs typically prefer. Latency to a VDI is the #1 developer complaint, and while not perfect, this is a far superior experience in Codespaces.

3. Review directory structure, discussing how Codespaces has cloned the repo, all files here. Run the application by hitting `F5` or use `Run -> Start Debugging` menu. Go to `PORTS` section, show that the application is currently running locally on port 5000 in the codespace, but that may be mapped to a different port on your machine. 
  > 🎤 **Talk Track:** Discuss port visibility: This looks like it's running on local. We will show port configuration in .devcontainer file.
5. Open the app in a browser by opening the URL in `Local Address` column and show the current state of the application. This application is a mash-up of Reddit and Twitter. You can create a new frequency and Beam a Ray on that Frequency, and prism that Ray so that others can see you enjoyed that comment. Those are interactions with the app, which you will want to exist when you look into database entries. 

![Blazor Beams](https://user-images.githubusercontent.com/5066968/193055269-2573d7f7-8588-416b-83ff-692a90651700.gif)

6. Open the `devcontainer.json` file:
  - We are referencing a Docker Compose file. 
  > 🎤 **Talk track:** We're running two services on the same Codespaces machine, including a SQL service. We are building one Docker image for the frontend and using the Azure SQL Edge container from the MS Package Registry (you could use any other container registry if it suits you). That means we can do interesting things like use the SQL extension in our codespaces so that we can query a table on the container I am connected to.
  
  ![SQL Connect](https://user-images.githubusercontent.com/5066968/192897233-bb82372b-e895-44e4-9339-02a1facfd3aa.gif)

  - Service: this service is started when the Codespace creates
  - Settings: these are the container settings which has things like the SQL connection string
  > 🎤 **Talk track:** You can call out that we see the database password, but because all of the networking between containers is internal to the Codespace, it's safe. Trust us 😜 . Alternatively, you can use Codespaces Secrets to access external resources. 
  - Extensions: these extensions are useful for this application - dotnet tools, MSSQL access, Blazor framework helper. Personal extensions are separate.
  - Ports: define the ports that need to be accessible for your application
  - Scripts: PostCreate command is being used here, but there are other hooks available. You can pass in a command, or pass in a file like `on-create.sh` We're running this to create the container, but you can also do things like pre-populate a database.  
  - Features: If you have a standard container for development, but this application needs some small addition like an SSH server or the GitHub CLI, you can add it here to easily add features while building the Codespace. Otherwise, you would have had to add these to the Dockerfile to make them available in the container. 

5. Personalization **(Optional)**
- Extensions: Show what extensions you have installed by going to `Extensions`. This will be unique to you. You might have Copilot, an IDE theme, MySQL, etc. If you look at a particular extension, it's handy to show that the `identifier` is under 'More Info` from the right-hand pane. You would use the identifier if you wanted to include an extension in your .devcontainer file
  
  ![Extensions](https://user-images.githubusercontent.com/5066968/193059822-25424c32-e4c7-48b2-83a8-07305605d536.gif)
  
- Dotfiles: You have the option to use Dotfiles for additional personalization with codespaces. If you've got'em, show 'em. If using dotfiles, show the personalization - e.g. your terminal prompt. 
- Themes (Settings gear, “Color Theme”) (Sidebar)
  - Settings Sync with your login (Sidebar)


6. Other Interfaces **(Optional)**
  - You can connect to your codespaces via SSH if it's installed on the container you are connecting to. This allows you to use VIM. 
  - Open terminal run `gh cs list` to show your codespaces. 
  - If you run `gh cs ssh` you can show that your command prompt matches your Dotfiles command prompt
    - (Optional): `vim hi.text` to create a new file with vim, add some text, save and quit (good luck!) and you can see it in the Codespace in VS Code
  - Mention that Jetbrains IDEs are in beta

----
## Extended Demo #1 - Mono-repo, multi-dev persona - Mulitple DevContainers in the same repo
### We will also use the VS Code built-in creator for our new .devcontainer file
> **Note:** Qualify the audience, ensure they have an environment for which this will be useful

> **Also Note:** A completed result of this is available on the branch `multi-devcontainer` if you need to start from there.  You can also just directly go to the create a new codespace dialog and show selecting a devcontainer

> 🎤 **Talk Track** : There are often more than one type of development being done on a repo, especially large mono-repo style projects. In “Blazor Beams”, we are going to create a new dev persona.  This could be because we have multiple microservices and some devs only need a subset of that.  It could be because there are different tools needed by SQL developers.  In this case we will add an infrastructure dev persona that will work on adding terraform for deploying the application to Azure. To accommodate that effort, let’s create a new devcontainer for the IaC dev.

Let's start by copying our existing files into a `front-end folder and we can pretend the application doesn't have any codespaces setup at all.

1. Create a new branch in your Codespace called multi-devcontainer.
2. Create a front-end directory in .devcontainer and copy our existing configuration files (Dockerfile, devcontainer.json, docker-compose.yml) there. _Do not copy `on-create.sh`_

3. Create an infrastructure-dev directory in .devcontainer and copy our existing configuration files (Dockerfile, devcontainer.json, docker-compose.yml) there as well. _Do not copy `on-create.sh`_

4. Copy the following lines and add to features in the infrastructure-dev/devcontainer.json
	"ghcr.io/devcontainers/features/azure-cli:1": {},
	"ghcr.io/devcontainers/features/terraform:1": {}

 ![Feature set](https://user-images.githubusercontent.com/5066968/205164641-124dd416-f28b-47a1-9722-006ab79aee0f.png)

5. Install HashiCorp Terraform extension to the infrastructure-dev codespace. 
`Shift + CMD + X`. You can select the canonical name of the extension from the right hand panel of the extension page .
Add the hashicorp.terraform extension into the extensions list in the `.devcontainer/infrastructure-dev/devcontainer.json` file. To ensure the extension is automatically preloaded into the infrastructure teams codespace in the future. 
![extension selection](https://user-images.githubusercontent.com/5066968/205164580-622e87e5-b3da-4c72-ad6f-f702107075c9.png)

6. Commit your changes and push to your repo
Navigate to the repo in the UI, and select Code, select the dots under the codespaces tab, and New with Options… Select your new branch.
Now we have a new configuration and we can compare it to our original configuration on main.
![create with options](https://user-images.githubusercontent.com/5066968/205164743-a3b51ad7-f0f7-40c2-b079-9d3ca4506e5a.png)

7. Create a new codespace from the UI with the new infra dev persona’s codespace (.devcontainer/infrastructure-dev/devcontainer.json ) and notice that all the appropriate tools and the Terraform extension are installed and ready to go in that codespace. 

Recap:
We now have two codespaces defined, and the Terraform extension and tools are installed in the infrastructure-dev devcontainer.  Development teams or individuals can use different codespace configurations depending on their project needs.


8. Return to the re-built codespace and see the application running in the new codespace
> 🎤 **Talk Track**:  
>  - No uncommitted changes were lost, we can iterate on our devcontainer file without a bunch of lazy commit messages
>  - The data remained the same, but we are running in a new container image
>  - When we mess up the configutation we get a "fallback" configuration that we can see the issue in, and fix our edited files
9. Commit the Changes
10. Navigate to the browser or the command line to create a new codespace and see the choice between the two different devcontainer files 

### Demo Option 1A - using the vscode builder to create a devcontainer file
> 🎤 **Talk Track**: We may not have a devcontainer to start from, so we can use the builder to create a devcontainer file that we can iterate on

1. Move or Delete the devcontainer files in the root directory.
2. Create a new configuration from the builder that we have in VS code `CMD/CTL + Shift + P` / `Add Dev Container Configuration Files`
> 🎤 **Talk Track**: Since this is a .NET app, we will select that, but there are defaults in place for a lot of different types of applications.  This list is being populated based on the code that we have in this repo.
3. Select the menu options that feel good for your app to get started
> 🎤 **Talk Track**: We can now check various boxes for additional tools that we would like to have defaulted into the container, we can say the ssh server so that we can connect via ssh to the dev machine, powershell if we had some powershell scripts in the application, etc.
4. Now we have a new configuration and we can compare it to our original configuration.
> 🎤 **Talk Track**: Notice that we have created in the devcontainer folder a new set of files. They look a lot like our exisitng configuration since we have the same type of development selections, but the SQL server container is different. This container also has some functionality to take a dacpac file for some database defaults that could be really helpful to start with a populated database. We will also see that some of the code around installing MSSQL tools for example, is 
5. While we wait for the codespace to rebuild with our new configuration `CMD/CTL + Shift + P` / `Rebuild Container`, we can talk about codespaces pre-builds (on the next slide)
6. **(Optional)**  Illustrate how to create a pre-build in the UI `Settings -> Codespaces -> Setup PreBuild` 
> 🎤 **Talk Track**:  If the branch doesn't have a devcontainer, the default devcontainer file will be available

----
## Extended Demo #2 
Multi-repo, adding access to additional repos from your codespace
### This demo can run following the first extended demo, or independently
> **Note:**  The completed version of this demo can be found in the `multi-repo` branch, you can start there and just show the result by creating a new codespace from that branch, or show the create experience with authorizing access to the new repo.

Now let’s say that we have another repository that we want to access - octodemo/octodemo-twitch is from myoctocat.com
This will get us some octocat pictures that we want to incorporate into the application.

> 🎤 **Talk Track**: **The repos Have to be in the same org**

1. I can’t clone this repository yet, because I don’t have access - `gh repo clone octodemo-twitch`
> 🎤 **Talk Track**:  GitHub Codespaces aren't built with the same access that your user has.  With security in mind, they are built with a freshly minted GITHUB_TOKEN that has limited permissions. You have to specifically configure which repos this codespace will have permission to access.   You could add a token as a codespaces secret, that token would be available as an environment variable in your codespace and you could reference it for git operations - that would be less secure, and every dev would have to add their own token in for use.  We can do better than that by identifying exactly the repos that this codespace will need to reference.

2. We can add some codespaces customization. GitHub Codespaces specify repo permissions so that the user can authorize these to run the current codespace, and the codespace can have the permissions that we would expect
``` 
"customizations": {
	"codespaces": {
		"repositories": {
			"octodemo/octodemo-twitch": {
				"permissions": {
					"contents": "read",
					"pull_requests": "write"
				}
			}
		}
	}
},
```
> 🎤 **Talk Track**: devcontainer is an open standard, that you can find more about [here](https://containers.dev/) codespaces specific configurations, like allowing other repos you have access to go under this "codespaces" section of the devcontainer customizations
2. We can’t just rebuild the container, because the codespace needs to be created from scratch to pick up the new permissions. 
  - Save and commit the change to your codespace
  - Create a new codespace from the UI (or the CLI). You will get a dialog requesting additional permissions for your new codespace. 
  - Once the new codespace is created you will be able to run the same command and clone the repo successfully.

3. Once the new codespace is created you will be able to run the same command and clone the repo successfully. with `gh repo clone octodemo-twitch`
> 🎤 **Talk Track**: Note that we would still have to make a change in the `on-create.sh` script or another lifecylce script to clone that repository to the codespace by default.  This gives us access to the repo, but doesn't pull it to the codespace.

----
## Extended Demo #3 VSCode Remote Containers Extension and local dev
> **Note:** Have Docker desktop installed, running and tested
1. Open the repo locally
2. `CMD/CTL + Shift + P` / `Open in local container`
3. Show the containers running in Docker dashboard
> 🎤 **Talk Track**: I still get this dev env as code, but I can run this offline
