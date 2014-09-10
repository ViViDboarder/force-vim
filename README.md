force-vim
=========
Plugin for "compiling" Salesforce.com code with [force cli](http://github.com/heroku/force)

Integrates with [vim-dispatch](https://github.com/tpope/vim-dispatch) and [vim-airline](https://github.com/bling/vim-airline)

Installation
------------
* Install the [force cli](http://github.com/heroku/force)
* Use Vundle or something similar to install this plugin

Configuration
-------------

  * `let g:force_dispatch_background = 0`: Set to 1 to use vim-dispatch to background any commands
  * `let g:force_disable_airline = 0`: Set to 1 to disable integration with vim-airline

Usage
-----

  * `ForceDeploy`: executes `force push` to deploy file to server
  * `ForceTest`: executes `force test` to run tests in current class
  * `ForceActive`: Displays currently active target
  * `ForceActive ?`: List all orgs
  * `ForceActive orgName`: Activate specified org
  * `ForceLogin`: Re-login to current org
  * `ForceLogin url`: Login to provided url

Experimental:
  * `ForceNewExecAnon`: Start new scratch window for executing anonymous code
  * `ForceExecScratchAnon`: Execute contents of buffer


Based on plugin [vim-abuse-the-force](http://github.com/ViViDboarder/vim-abuse-the-force)
