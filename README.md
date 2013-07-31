# ESA 2013 workshop on Data Visualization using R.

Welcome to the GitHub repository for the [data visualization workshop](http://eco.confex.com/eco/2013/webprogram/Session9052.html).

**Location and time:** 101B, Minneapolis Convention Center.  
0800 - 11:30

## Organizers
Naupaka Zimmerman, Karthik Ram, and Andrew Tredennick.

---

## Pre workshop instructions

**Important:** There will be no wifi in conference rooms this year so please plan on spending 10 minutes on Saturday night (or from the conference lobby on Sunday morning) to install the packages listed below and also download a local copy of this repository (see instructions below).

### Installing R  
If you don't already have R set up with a suitable code editor, we recommend downloading and installing [RStudio](http://www.rstudio.com/ide/download/) for your platform. Once installed, open RStudio and install the following packages. Simply paste these commands into your prompt. 

### Installing packages

```coffee
install.packages("ggplot2", dependencies = TRUE)
install.packages("plyr")
install.packages("reshape2")
install.packages("devtools")
# Then a few packages to acquire data from the web to visualize
install.packages("rfisheries")
install.packages("rgbif")
install.packages("taxize")
```
### Downloading code/data from this repository  
If you're already familiar with Git, then simply clone this repo (but please wait until Sat afternoon to get the latest changes). If you're not familiar with Git, simply hit the Download Zip button on the right side of this page.


![](how_to_clone.png)

If you're having any trouble with these steps, please drop us an [email](mailto:karthik.ram@gmail.com). We'll also strive to have local copies if you forget to install any of these tools.

See you Sunday!
