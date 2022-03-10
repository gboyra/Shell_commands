#++++++++++++++++++++++++++++++
# Introduction to Shell bash ++
#++++++++++++++++++++++++++++++

# DataCamp course


# 1. Manipulating files and directories --------
#++++++++++++++++++++++++++++++++++++++++++++++++
# Where am I?
pwd

# What is there there? "ls" lists what is in there
ls
ls directory
ls file.txt
ls *.txt
# if the path starts with "/" the shel interprets it as an absolute path
# otherwise it is relative
# "/" is the root directory

# Change directory "cd"
cd directory
cd /absolute/path
cd .  # current directory
cd ..  # directory above; similarly:
ls .  # same as ls
ls ..  # lists the parent directory
cd ~  # home (not working) directory; this allways takes you home 
ls ~
 
# Create files
touch file.txt  # this creates an empty file
   
# Copy files
cp original.txt duplicate.txt
# if duplicate.txt existed, it will be overwritten

cp dir1/original.txt dir2/duplicate.txt
cp file1.txt file2.txt dir  # copies both files in dir
cp dir1/file1.txt dir2/file2.txt dir3

# Move files
mv seasonal/spring.csv seasonal/summer.csv backup
mv file1.txt ..
mv dir1 dir2
mv dir1 ..

# mv can also be used to rename files
mv spring.txt summer.txt  # changes the name of the file
# be careful, this would also delete whatever is in summer.txt

mv dir1 dir2
# if dir2 doesn't exist, this renames dir1 into dir2
# if dir2 exists, this renames dir1 and removes former dir2 

# Remove files
rm file1.txt
rm file1.txt file2.txt
rm *.txt
rm dir/*.txt

# Remove directories
rmdir dir1
# your can only do this if they are empty

# Create directories
mkdir newdir


# 1. Manipulating data --------------------------
#++++++++++++++++++++++++++++++++++++++++++++++++

# show the contents of a file with cat:
cat leeme.txt
# it's called cat because it concatenates all the files you give it:
cat file1.txt file2.txt file3.txt  # etc...

# a more powerful alternative is "less" (it replaced the older "more")
less file1.txt file2.txt file3.txt 
# less has commands to help navigating the file (:n page down, :p page up, :q quit)

# the shell has text completion pressing tab

# display the first lines of a file:
head leeme.txt  # displays first 10 lines
head -n 3 leeme.txt  # the first 3 lines 
tail -n +7 seasonal/spring.csv
# read 


# Display everything inside a directory (even inside subdirectories)
ls -R
# Display infromative marks to distinguish directories and programs:
ls -F
ls -F -R  # this provides a quite useful overview of your working directory

# select columns from a file:
cut -f 1-8, 10 -d , file.txt  # select -fields (columns) 1-8 and 10 -delimited by a comma

# Get help about a command:
man command-name
info command-name

# Print a list of recent commands with "history"
history
# typing !number will rerun that particular command in the list
!35
# you can also re-run the most recent use of a command:
!add
!git

# 2.1 grep - print lines by their contents ------------
#++++++++++++++++++++++++++++++++++++++++++++++++++++++

# this could be pretty useful for searching inside your scripts

# grep selects and prints lines according to what they contain
# (You can search patterns, regular expressions, with grep)
grep shit winter.csv  # prints lines containing "shit" in winter.csv
# It has useful flags: 
# -c: print a count of matching lines rather than the lines themselves
# -h: do not print the names of files when searching multiple files
# -i: ignore case (e.g., treat "Regression" and "regression" as matches)
# -l: print the names of files that contain matches, not the matches
# -n: print line numbers for matching lines
# -v: invert the match, i.e., only show lines that don't match
grep -n ls 'Introduction to shell bash.R' 
grep -c ls 'Introduction to shell bash.R' 
grep -c "Introduction to shell bash.R" "shell_commands.txt"


# 3. Combining tools -----------
#+++++++++++++++++++++++++++++++

# Store a command's output in a file with >
head -5 shell_commands.txt > top.txt

# 3.1 Pipes ------------
#+++++++++++++++++++++++
 
# You can chain any number of commands with pipes
# Pipes in shell are marked with | 
cut -f 2 -d , summer.csv | grep -v Tooth
# select column 2 in summer.csv and then exclude the line containing Tooth

# Counting characters, words and lines (wc)
grep 2017-07 spring.csv | wc -l
# Find lines of July in spring.csv and then count them


# 3.2 Wildcards ------------
#+++++++++++++++++++++++++++
# Most shell commands work with multiple files when adding many filenames
# To make life easier, shell provides wildcards
# * Means "mathc zero or more characters"
cut -d , -f 1 seasonal/*
grep cut -n *shell*  # prints the lines containing cut in all shell-files
grep cut -c *shell*  # prints the number of lines in each of the 3 files
  
# Other wildcards:
# ? Matches a single character
# [...] Matches any of the characters inside the brackets:
  201[78]  # could be 2017 or 2018
# {...} Matches any comma-separated patterns inside the curly brackets
{*.txt, *.csv}  # matches any txt and csv files

# Sorting files with sort
# by default sorts in ascending alphabetical order, but flags:
# -n: does numerically
# -r: reverses
# -b: ignore leading blanks
# -f: folds (be case insensitive)
# Pipelines often use grep to get rid of unwanted records
# and then sort out their result
cut -d , -f 2 summer.csv | grep -v Tooth | sort -r | head -5

# Remove duplicate files with uniq
# Notice that it removes only adjacent duplicated
# So yoou need to use it in pipeline after sort:
cut -d , -f 2 seasonal/winter.csv | grep -v Tooth | sort | uniq -c
# "uniq -c" adds a count of repetitions of each unique value

# Of course we can store the output of a pipe with ">"
head -n 3 seasonal/winter.csv > result.txt  # or, alternatively:
> result.tx head -n 3 seasonal/winter.csv  # quite awkward...

# Stop running a program with Crtl + C (Ctrl + c)

# 4. Batch processing ------------
#+++++++++++++++++++++++++++++++++

# "set" lists the environmental variables (long list)
# We can pipe it trhough grep to filter by names:
set | grep HISTFILESIZE
set | grep HOME
set | grep PWD
set | grep SHELL
set | grep USER

# To print the value of a variable use echo and a $ sign:
echo USER
echo $USER
echo $HOME
~

# Shell variables
var.name=5
echo $var.name
testing=shell_commands.txt
head -n 3 $testing

# 4.1 Loops ------------
#+++++++++++++++++++++++

for filetype in gif jpg png; do echo $filetype; done
# notice the structure of the for statement

for filename in seasonal/*; do echo $filename; done
for file in seasonal/*.csv; do head -n 2 $file | tail -n 1; done
for file in seasonal/*.csv; do grep 2017-07 | tail -n 1; done

# To do multiple tasks in a single loop, separate them with ";"
for f in seasonal/*.csv; do echo $f; head -n 2 $f | tail -n 1; done
# if you forget to add the ";":
for f in seasonal/*.csv; do echo $f head -n 2 $f | tail -n 1; done
# it will echo "$f" AND "head -n2 $f" one after the other in the same line


# 5. Creating new tools ---------------
#++++++++++++++++++++++++++++++++++++++

# text editors
nano file.txt
# is a peculiar text editor embedded in the command line
# Ctrl + K: delete a line
# Ctrl + U: un-delete (paste) a line
# Ctrl + O: save the file
# Ctrl + X: exit the editor


history tail -n 5 > last_commands.txt
cp last_commands.txt ~  # copy them to the home directory (wherever this is)


# 5.1 Shell scripts: Save commands to rerun later -------------
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Because the commands are just text, you can store them
# in files for the shell to run them over again with "bash"
nano phist.sh
# inside nano: 
history tail -n 5 > last_commands.txt  # then save and:
bash phist.sh

# How can I pass filenames to scripts? (last chapter)


