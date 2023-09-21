#!/bin/bash

# Check if the parameter is provided
if ! [[ -s "$1" ]]; then #Проверяет, существует ли файл и не является ли он пустым.
  echo "Пожалуйста, введите параметр путь директории"
  exit
fi

# Get the absolute path of the directory
# directory=$(realpath "$1")
# ${1: -1}

# Check if the directory exists
if [[ ! -d "$1" ]]; then #Проверяет, существует ли файл и является ли он каталогом.
  echo "Каталога не существует"
  exit
fi

last_symbol="${1: -1}"
# if ! [[ "$last_symbol" =~ "/" ]]; then
if [ ${1: -1} != "/" ]; then
  echo hello
  exit
fi

# Function to calculate the size of a directory
get_directory_size() {
  sudo du -sb "$1" | awk '{print $1}'
}

# Function to calculate the number of files in a directory
get_file_count() {
  sudo find "$1" -type f | wc -l
}

# Function to calculate the number of files with a specific extension in a directory
get_file_count_by_extension() {
  sudo find "$1" -type f -name "*.$2" | wc -l
}

# Function to get the top N folders with the largest weight
get_top_folders() {
#   find "$1" -type d 2>/dev/null -exec du -s {} + | sort -nr | head -n "$2"
# find $1* -type d 2>/dev/null -exec du -h {} +|sort -hr| sed -n '1,5'p | awk '{print NR, "-", $2",", $1}'
sudo du -h "$1"/* 2>/dev/null | sort -rh | head -n 5 | awk '{print NR " - " $2 ", " $1}'
}

# Function to get the top N files with the highest weight
get_top_files() {
  sudo find "$1" -type f -exec du -h {} + | sort -rh | head -n 10 | awk '{print NR " - " $2 ", " $1}' 
# find $1* -type f 2>/dev/null -exec du -h {} + |sort -hr| sed -n '1,10'p | awk '{printf("%d - %s %s, ",NR,$2, $1); system("bash -c '\''file -b --mime-type "$2"'\''")}'
}
# Function to get the top N executable files with the largest weight
get_top_executables() {
  # sudo find "$1" -type f -executable -exec du -ah {} + | sort -hr | head -n "$2"
 sudo find "$1" -type f -executable -exec du -b {} + | sort -rh | head -n 10 | awk '{print NR " - " $2 ", " $1/1024/1024 " MB, " system("md5sum " $2) | getline md5; print md5}'

}

# Start the timer
start_time=$(date +%s.%N)


# total_folders=$(find "$1" -type d | wc -l)


# total_files=$(get_file_count "$1")


# config_files=$(get_file_count_by_extension "$1" "conf")


# text_files=$(get_file_count_by_extension "$1" "txt")


# executable_files=$(get_file_count_by_extension "$1" "sh")


# log_files=$(get_file_count_by_extension "$1" "log")


# archive_files=$(get_file_count_by_extension "$1" "zip")


# symbolic_links=$(find "$1" -type l | wc -l)


# top_files=$(get_top_files "$1" 10)


# top_executables=$(get_top_executables "$1" 10)


# end_time=$(date +%s.%N)
# execution_time=$(echo "$end_time - $start_time" | bc)
# execution_time=$("print('{:.1f}'.format(${end_time} - ${start_time}))")

# Output the information
echo "Total number of folders (including all nested ones) = $(find "$1" -type d | wc -l)"# Calculate the total number of folders
echo "Top 5 folders of maximum size arranged in descending order (path and size): $(get_top_folders "$1" 5)"
echo "Total number of files = $(get_file_count "$1")"# Calculate the total number of files
echo "Number of:"
echo "Configuration files (with the .conf extension) = $(get_file_count_by_extension "$1" "conf")s"# Calculate the number of configuration files
echo "Text files = $(get_file_count_by_extension "$1" "txt")"# Calculate the number of text files
echo "Executable files = $(get_file_count_by_extension "$1" "sh")"# Calculate the number of executable files
echo "Log files (with the extension .log) = $(get_file_count_by_extension "$1" "log")"# Calculate the number of log files
echo "Archive files = $(get_file_count_by_extension "$1" "zip")"# Calculate the number of archive files
echo "Symbolic links = $(find "$1" -type l | wc -l)"# Calculate the number of symbolic links
echo "Top 10 files of maximum size arranged in descending order (path, size and type):"
echo "$(get_top_files "$1" 10)"# Get the top 10 files with the highest weight
echo "Top 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
echo "$(get_top_executables "$1" 10)"# Get the top 10 executable files with the largest weight
end_time=$(date +%s.%N)# Calculate the script execution time
execution_time=$(echo "$end_time - $start_time" | bc)
echo "Script execution time (in seconds) = $execution_time"