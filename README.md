NOTES
========

To use this thor program you must do the following:

* Install thor in your current ruby
* Run the following at the base of this project:
  thor install lib/kata.rb
* Give it a name of kata for a namespace
* Check with thor list installed
* Run:
  thor kata:help

Assumptions are that you are using ruby 2.2, rvm, and a default spec_helper for your katas.  These can all be updated simply by updating the kata.rb file and its specs whenever an update is needed.  You then run:

  thor update kata

It will look where you last installed it from and update automatically.  If you can't do this for some reason you can simply uninstall/reinstall in thor.
