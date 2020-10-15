#!/bin/bash

clear
if [ ! -d "/Users/bhayek/Desktop/iphoneMoviesToDelete/" ];
then
	mkdir /Users/bhayek/Desktop/iphoneMoviesToDelete/
fi

if [ ! -d "/Users/bhayek/Desktop/iphoneScreenRecordings/" ];
then
	mkdir /Users/bhayek/Desktop/iphoneScreenRecordings/
fi


echo "
==============================================================================

1. copy all the files from your iPhone to a folder on your Mac. 
   (This is easily done with the imageCapture application.)
2. Drag the folder with all your iPhone photos into this window and press ENTER.
3. The script will find and move any LIVE VIEW videos to a directory 
   on your deskotp called 'iphoneMoviesToDelete'
4. Any iPhone screen recordings will be moved to a folder on 
   your desktop called 'iphoneScreenRecordings'

NOTE: No iPhone photos will be touched or moved during this process.

==============================================================================
                            (To abort, close this window or type 'CNTROL + C')


 _______________________________
|                               |
|      From which folder        |
|      would you like to        |
|      delete LIVE VIEW         |
|      iPhone video files?      |
|                               |
|                               |
|                               |
|      [ DRAG FOLDER HERE ]     |
|                               |
|       Then press 'ENTER'      |
|                               |
|_______________________________|
"
read sourcefolder
clear
cd $sourcefolder
originalFilesInSourceFolder=$(ls | wc -l)
echo "
Reviewing $originalFilesInSourceFolder files in:
$sourcefolder


"
#execute search
for i in $(find $sourcefolder -type f -name "*JPG" -o -name "*.JPEG" -o -name "*.HEIC");
	do
		if [ -f "${i%.*}.MOV" ]
			then
				mv ${i%.*}.MOV /Users/bhayek/Desktop/iphoneMoviesToDelete/
		fi
	done

for i in $(find $sourcefolder -type f -name "*.MP4");
	do
		mv ${i%.*}.MP4 /Users/bhayek/Desktop/iphoneScreenRecordings/
	done

remainingPhotos=$(ls | wc -l)
videosThatWereNotMoved=$(ls *.MOV | wc -l)
cd /Users/bhayek/Desktop/iphoneMoviesToDelete/
videosToDelete=$(ls | wc -l)
cd /Users/bhayek/Desktop/iphoneScreenRecordings/
screenRecordingsCount=$(ls | wc -l)



echo "
1. $videosThatWereNotMoved videos were not associated with any photos and have been left in place.
2. $videosToDelete liveView videos were found and have been moved to a folder on your desktop called iphoneMoviesToDelete.
3. $remainingPhotos photos remain in $sourcefolder.
4. $screenRecordingsCount iPhone screen recordings were moved to /Users/bhayek/Desktop/iphoneScreenRecordings/
5. These folders have been opended so that you can review the results.
"

open /Users/bhayek/Desktop/iphoneMoviesToDelete/
open /Users/bhayek/Desktop/iphoneScreenRecordings/
open $sourcefolder


