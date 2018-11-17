#!/usr/bin/env bash

#create directory to hold transcript txt files
mkdir -p ~/Documents/TAZ/Transcripts
cd ~/Documents/TAZ/

# read in each link to transcript from txt file
input="./TAZ_transcripts_links.txt"
counter=1
fileid_regex=".{77}(.{44}).*"
while IFS= read -r transcipt_link
do
  # create descriptive file name for the output based on loop counter 'EP_<counter>.txt'
  outfile_name="./Transcripts/EP_$counter.txt"

  # use regex to get the file id from the link
  [[ $transcipt_link =~ $fileid_regex ]]
  fileid=${BASH_REMATCH[1]}

  # insert file id into the URL that will be used by curl to download the transcript
  download_link="https://docs.google.com/feeds/download/documents/export/Export?id=$fileid&exportFormat=txt"

  # use curl to download the text file of the transcript with descriptive file name
  curl -o $outfile_name $download_link

  ((counter+=1))
done < "$input"


# commands for the download
# curl -o EP69.txt "https://docs.google.com/feeds/download/documents/export/Export?id=1JD96MsBuYyGvJxly6rAuwwvSic_dGajXc0OSakr9eGk&exportFormat=txt"
# - OR -
# wget -O EP692.txt "https://docs.google.com/feeds/download/documents/export/Export?id=1JD96MsBuYyGvJxly6rAuwwvSic_dGajXc0OSakr9eGk&exportFormat=txt"
