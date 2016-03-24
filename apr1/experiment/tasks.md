# Tasks

Work on intro here.

Tell them to always use the plugin they are given as much as possible, and also to make sure they copy the comment accompanying each copy as well (it will tell us in our logs where they are at progress wise).

## Task 1
[copy source from multiple windows][inside editor copy]

In /keymaps/clipboard-history.cson you will find keymaps for our package, however, we only have keymaps for 'platform-darwin', we need to make sure our windows and linux friends can use our plugin too!

Head on over to /source/source1 to grab your first copy, the windows keymaps. Copy this (remember to grab the comment too) and then paste it back in our clipboard-history.cson underneath the 'platform-darwin' block.

As well head over to /source/source2 to grab the second copy, our linux maps, and repeat the exercise, copying and pasting the block underneath the windows block this time.

## Task 2
[copy source from multiple windows][inside editor copy]

The next task deals with the file clipboard-history.cson, but not the one inside keymaps, this time we are concerned with the one inside /menus/clipboard-history.cson.

This is the file that populates our menu items, but it seems like everything has gone missing, probably a bad github commit... Anyways lets fix this up! You won't have as much direction on this one but you have all the information you need to figure this out.

There are four copies you need to make and paste at line 7 marked with the comment '#task 2 - paste below here!', these four copies are distributed across the files source1 - source 4 inside /source/ and are marked with comments like '#task 2 - copy 1'. Make sure you paste them all in order!

## Task 3
[copy source from multiple windows][inside editor copy][outside editor copy]

For this next task we are going to need some help from online, head to [this url](https://raw.githubusercontent.com/cleebp/csc-510-group-g/master/apr1/experiment/base/source/onlineSource.md) and copy the lines marked by '#task 3 - copy 1', you know the deal. Once you have this copied head back to /menus/clipboard-history and paste it on line 8 below the comment.

We also have another copy inside /source/source1 marked by a comment that you will need to put below '#task 3 - 2nd paste below here!' inside /menus/clipboard-history which was part of the paste we just did.

## Task 4
[copy source from single window][inside editor copy][clipit-cmd]

For this next task we will be taking 3 different copies from /source/source4 and placing them all inside /styles/clipboard-history.less.
Simply navigate to the source4 directory and you will see the 3 items you need to copy with comments telling you the order to copy them in. However you would like, copy these 3 items and place them in the correct order inside /styles/clipboard-history.less (look for the comments to help with order, and be mindful of the tabs they are important).

## Task 5
[copy source from multiple windows][inside editor copy]

This task will deal with pasting items back into /lib/clipboard-history.coffee (note: this does not have to deal with clipboard-history-view, these are very different files). In this file you will see comments for where 3 pastes need to happen in order, these 3 items are located across /source/source1, source2, and source3, and they are denoted with comments like '#task 5 - copy 3'.

Try to be careful of spacing and make sure everything ends up in order!

## Task 6
[copy source from multiple windows][inside editor copy]

Just like in task 5 this task will deal with finding 3 copies across /source/source2, source3, and source4, to then paste in the correct order inside /lib/clipboard-history.coffee.

## Task 7
[copy source from multiple windows][paste across multiple windows][inside editor copy]
First we are going to find some missing parts of package.json, you have two copies you need to make that are located in /source/source1 and source2, these are labeled with appropriate comments and their paste locations are also labeled inside package.json.

Next we need to find some missing pieces of /lib/clipboard-history-view.coffee. There are 2 total copies here and they are located inside /source/source1 and source2, their paste locations are inside clipboard-history-view.coffee and are labeled with comments.

## Task 8
[copy source from multiple windows][paste across multiple windows][inside editor copy]
Just like the last task, first we are going to find some missing parts of package.json, you have two copies you need to make that are located in /source/source3 and source4 (different source files from task 7!), these are labeled with appropriate comments and their paste locations are also labeled inside package.json.

Again, just like in task 7, we need to find some missing pieces of /lib/clipboard-history-view.coffee. There are 2 total copies here and they are located inside /source/source3 and source4, their paste locations are inside clipboard-history-view.coffee and are labeled with comments.

## Task 9
[copy source from multiple windows][inside editor copy]
Oh no! It looks like all of /lib/clipboard-history-view.coffee has been broken apart and split between /source/source1 -> source4. You know the deal, you are looking for 4 copies spread out between these four source directories, make sure you copy them and paste them in the correct locations (look for the comments for task 9).

## Task 10
[copy source from multiple windows][inside editor copy]
Okay you know the deal, just like in task 9 /lib/clipboard-history-view.coffee has been broken apart and split between /source/source1 -> source4. You are looking for 4 copies spread out between these four source directories, make sure you copy them and paste them in the correct locations (look for the comments for task 10).
