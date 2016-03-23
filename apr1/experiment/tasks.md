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
