OrderParser
===========

System to read e-mail messages, parse Americart orders, and shove them into a database, then write a report when needed.  Only for curiosity's sake -- doesn't work any more.


------------------------------------------------------------------------
r444 | pbirmingham | 2007-01-10 22:48:39 -0600 (Wed, 10 Jan 2007) | 1 line

found bug in item count handling when generating reports
------------------------------------------------------------------------
r438 | pbirmingham | 2006-07-13 17:34:04 -0500 (Thu, 13 Jul 2006) | 1 line

dumbass deleted repo.  This is getting checked in to the mar 29 version.
------------------------------------------------------------------------
r437 | pbirmingham | 2006-03-29 17:19:13 -0600 (Wed, 29 Mar 2006) | 1 line

more clean-up
------------------------------------------------------------------------
r436 | pbirmingham | 2006-03-27 17:51:37 -0600 (Mon, 27 Mar 2006) | 1 line

Recovering a bit of lost GUI work, and slightly refactoring mail parser
------------------------------------------------------------------------
r435 | pbirmingham | 2006-03-16 17:52:51 -0600 (Thu, 16 Mar 2006) | 1 line

altered parseMail to use YAML for configuration
------------------------------------------------------------------------
r434 | pbirmingham | 2006-03-11 23:27:08 -0600 (Sat, 11 Mar 2006) | 1 line

GUI work proceeds
------------------------------------------------------------------------
r432 | pbirmingham | 2006-03-06 16:47:34 -0600 (Mon, 06 Mar 2006) | 1 line

Adding parserConfig.rb
------------------------------------------------------------------------
r431 | pbirmingham | 2006-03-06 16:46:51 -0600 (Mon, 06 Mar 2006) | 3 lines

Moved server and login information into parserConfig.rb
Added pattern and logic for Paypal orders
Removed code to move processed messages
------------------------------------------------------------------------
r430 | pbirmingham | 2006-02-20 00:22:00 -0600 (Mon, 20 Feb 2006) | 1 line

fixed a bug in report generation
------------------------------------------------------------------------
r429 | pbirmingham | 2006-02-20 00:21:07 -0600 (Mon, 20 Feb 2006) | 3 lines

Changes to facilitate handling messages siphoned from IMAP.  Date processing moved outside the Order object.

Now messages are pulled from the designated IMAP mailbox, and moved to a second mailbox after their orders are loaded into the database.
------------------------------------------------------------------------
r428 | pbirmingham | 2006-02-08 17:45:34 -0600 (Wed, 08 Feb 2006) | 1 line

making GUI headway
------------------------------------------------------------------------
r427 | pbirmingham | 2006-01-26 17:21:57 -0600 (Thu, 26 Jan 2006) | 1 line

adding the gui shell stuff
------------------------------------------------------------------------
r425 | pbirmingham | 2006-01-24 06:45:22 -0600 (Tue, 24 Jan 2006) | 1 line

Duplicate rejection works
------------------------------------------------------------------------
r424 | pbirmingham | 2006-01-19 17:11:01 -0600 (Thu, 19 Jan 2006) | 1 line

Have the backend based on MySQL and the segfault is gone.  I think that the Firebird adapter is still a little flaky.
------------------------------------------------------------------------
r423 | pbirmingham | 2006-01-17 23:59:13 -0600 (Tue, 17 Jan 2006) | 1 line

Fixed parsing bug that caused a few Americart orders to be missed (2 out of 126, which had a 4-digit number between the headers and the body)
------------------------------------------------------------------------
r422 | pbirmingham | 2006-01-17 17:16:02 -0600 (Tue, 17 Jan 2006) | 1 line

committing before I mess something up
------------------------------------------------------------------------
r421 | pbirmingham | 2006-01-09 07:09:34 -0600 (Mon, 09 Jan 2006) | 1 line

Branch for GUI development
------------------------------------------------------------------------
r419 | pbirmingham | 2006-01-05 17:58:07 -0600 (Thu, 05 Jan 2006) | 1 line

fixed an error in tax calculation
------------------------------------------------------------------------
r418 | pbirmingham | 2006-01-05 17:52:16 -0600 (Thu, 05 Jan 2006) | 1 line

yay!  It works!
------------------------------------------------------------------------
r417 | pbirmingham | 2006-01-05 17:20:22 -0600 (Thu, 05 Jan 2006) | 1 line

order object and database are just fine; now gotta get report generator finished
------------------------------------------------------------------------
r416 | pbirmingham | 2006-01-05 06:30:13 -0600 (Thu, 05 Jan 2006) | 1 line

Working on report generator
------------------------------------------------------------------------
r415 | pbirmingham | 2006-01-05 06:09:58 -0600 (Thu, 05 Jan 2006) | 1 line

broke item and order out into separate files
------------------------------------------------------------------------
r414 | pbirmingham | 2006-01-04 22:52:33 -0600 (Wed, 04 Jan 2006) | 1 line

Okay, this iteration gets it right.  We have December orders in the bag!
------------------------------------------------------------------------
r413 | pbirmingham | 2006-01-04 17:42:17 -0600 (Wed, 04 Jan 2006) | 1 line

workin'
------------------------------------------------------------------------
r412 | pbirmingham | 2006-01-04 17:14:45 -0600 (Wed, 04 Jan 2006) | 1 line

Active record freakin' rocks.  Have orders and items persisted in DB.  Need to work on parsing for costs more.
------------------------------------------------------------------------
r411 | pbirmingham | 2006-01-03 18:00:48 -0600 (Tue, 03 Jan 2006) | 1 line

Going to ActiveRecord
------------------------------------------------------------------------
r410 | pbirmingham | 2005-12-28 06:26:49 -0600 (Wed, 28 Dec 2005) | 1 line

item parsing needs work!
------------------------------------------------------------------------
r409 | pbirmingham | 2005-12-22 19:27:29 -0600 (Thu, 22 Dec 2005) | 1 line

Cleaned out CCNow stuff, got address parsing methods in.
------------------------------------------------------------------------
r408 | pbirmingham | 2005-12-22 18:34:00 -0600 (Thu, 22 Dec 2005) | 1 line

Filled in attributes, about to rip out ccnow stuff
------------------------------------------------------------------------
r407 | pbirmingham | 2005-12-21 17:05:00 -0600 (Wed, 21 Dec 2005) | 1 line

Renamed remotely
------------------------------------------------------------------------
r406 | pbirmingham | 2005-12-21 17:03:16 -0600 (Wed, 21 Dec 2005) | 1 line

initial import
------------------------------------------------------------------------
