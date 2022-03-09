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


