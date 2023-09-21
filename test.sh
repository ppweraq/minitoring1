#!/bin/bash

d_amount="$(sudo find "$path" -type d | wc -l)"
d_name="$(sudo du -h $path | sort -hr | head -6 | awk '{print$2}')"
d_size="$(sudo du -h $path | sort -hr | head -6 | awk '{print$1}')"
f_amount="$(sudo find "$path" -type f | wc -l)"

conf="$(sudo find $path | grep -c ".conf$")"
text="$(sudo find $path -type f -exec file . -b {} \; | grep -c text)"
exec="$(sudo find $path -type f -perm /a=x | wc -l)"
log="$(sudo find $path | grep -c ".log$")"
archive="$(sudo find $path -type f -exec file . -b {} \; | grep -c -e compress -e archive)"
symbolic="$(sudo find "$path" -type l | wc -l)"

f_name="$(sudo find $path -type f -exec du -h {} \; | sort -hr | head -10 | awk '{print$2}')"
f_size="$(sudo find $path -type f -exec du -h {} \; | sort -hr | head -10 | awk '{print$1}')"
f_type="$(sudo find $path -type f -exec du -h {} \; | sort -hr | head -10 | awk -F. '{print $NF}')"

g_name="$(sudo find $path -type f -perm /a=x -exec du -h {} + | sort -hr | head -10 | awk '{print$2}')"
g_size="$(sudo find $path -type f -perm /a=x -exec du -h {} + | sort -hr | head -10 | awk '{print$1}')"
g_hash="$(sudo find $path -type f -perm /a=x -exec md5sum {} + | sort -hr | head -10 | awk '{print$1}')"

export d_amount
export d_name
export d_size
export f_amount

export conf
export text
export exec
export log
export archive
export symbolic

export f_name
export f_size
export f_type
export g_name
export g_size
export g_hash 

./print.sh 

#!/bin/bash

dir_name=($d_name)
dir_size=($d_size)
file_name=($f_name)
file_size=($f_size)
file_type=($f_type)
exec_name=($g_name)
exec_size=($g_size)
exec_hash=($g_hash)


echo "Total number of folders (including all nested ones) = "$((d_amount-1)) 
echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
for (( i=1; i<6; i++)); do
  echo "$((i)) - ${dir_name[i]}/, ${dir_size[i]}"
done
echo "Total number of files = "$f_amount
echo "Number of:"
echo "Configuration files (with the .conf extension) = "$conf
echo "Text files = "$text
echo "Executable files = "$exec
echo "Log files (with the extension .log) = "$log
echo "Archive files = "$archive
echo "Symbolic links = "$symbolic 
echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
for (( i=0; i<10; i++)); do
  echo "$((i+1)) - ${file_name[i]}, ${file_size[i]}, ${file_type[i]}"
done
echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
for (( i=0; i<10; i++)); do
  echo "$((i+1)) - ${exec_name[i]}, ${exec_size[i]}, ${exec_hash[i]}"
done