README
======

This is a project for The App Business.

Installation
------------

To install this project:


* 1 Download the zip and unzip on the desired folder

* 2 Install cocoapods if you don't have installed it:
  run in a Terminal: (is posible you need to run this command with sudo)
    >$ gem install cocoapods

* 3 Go to de folder and run the podfile
    >$ cd /path/to/the/folder/

    >$ pod install
  
* 4 open the 'Who is Who.xcworkspace' file

Notes
-----

The App connect to the wep page http://www.theappbusiness.com/our-team/ and get a list of the people working in the company.

You can update the list of employees with a pull to refresh.

The App works on screen sizes of 3.5 and 4 inches.

If there is just one employee the app load the profile view after the content is loaded from the web.