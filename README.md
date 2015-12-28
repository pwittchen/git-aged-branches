git-aged-branches
=================
shows git branches of defined repository with age of their last commit

it works on Mac OS X, Linux and can be helpful while investigating old git branches to delete

Usage
-----

```
./git-aged-branches.sh [options] [arguments]
 
options:
-h, --help                                            show brief help
-d, --directory=DIR                                   specify path to directory with git repository
-m, --merged=(merged|no-merged|merged <branch_name>)  show merged or not merged branches
```
