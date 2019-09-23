# DATIMUtils
**Repo Owner:** Scott Jackson [@jacksonsj](https://github.com/jacksonsj)


### Installation

1. Download R from http://cran.us.r-project.org/
2. Install R. Leave all default settings in the installation options.
3. Download RStudio from http://rstudio.org/download/desktop and install it. Leave all default settings in the installation options.
4. Open RStudio
5. Go to the “Packages” tab and click on “Install Packages”. The first time you do this you’ll be prompted to choose a CRAN mirror. R will download all necessary files from the server you select here. Choose the location closest to you.
6. Type in "devtools". Ensure that "Install dependencies" is checked, and click "Install". If you get permission errors while installing packages, close RStudio and reopen it with administrator privileges.
7. Open a new R Script in RStudio.
8. Copy and paste the following into that new file:

```R
library(devtools)
install_github(repo = "https://github.com/pepfar-datim/datimutils.git", ref = "demo")
library(datimutils)
```

9. Hit the `Run` button.
10. If you are prompted in the Console to select which packages to update, just hit Enter to bypass.
11. If this presents issues, contact the development team either through a [GitHub ticket](https://github.com/pepfar-datim/datimutils/issues/new), or via [DATIM Support](https://datim.zendesk.com) (DATIM users only).
12. If the package loads without issue, restart your R session.



Have a question? Find us on [GitHub](https://github.com/pepfar-datim/datimutils/issues/new) or [DATIM Support](https://datim.zendesk.com) (DATIM users only).
