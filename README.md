git-aged-branches
=================
shell script showing git branches of defined repository with age of their last commit

It works on Mac OS X, Linux and can be helpful while investigating old git branches to delete.

This script does not delete anything! It's just for informational purposes.

Usage
-----

clone repository or single script and use it as follows:

```
./git-aged-branches.sh [options] [arguments]
 
options:
-h, --help                                            show brief help
-d, --directory=DIR                                   specify path to directory with git repository
-m, --merged=(merged|no-merged|merged <branch_name>)  show merged or not merged branches
```

Exemplary output
----------------

![Skype fixed icon](https://github.com/pwittchen/git-aged-branches/blob/master/screenshot.png)
