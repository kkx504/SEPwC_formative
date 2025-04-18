#!/usr/bin/env Rscript
suppressPackageStartupMessages({
  library(argparse)
})

options(python_cmd = "C:/Users/Izzy/AppData/Local/Programs/Python/Python313/python.exe")


TASK_FILE <- ".tasks.txt" #nolint

add_task <- function(task) {
  write(task, file = TASK_FILE)
}

#remember to change where .tasks is going
list_tasks <- function() {
  counter <- 1 
  output_string <- ""
  tasks <- readLines(TASK_FILE)
  num_tasks <- length(tasks)
    for (item in tasks) {
    output_string <- paste0(output_string, counter, ". ", item)
      if (counter < num_tasks)
        output_string <- paste0(output_string, "\n")
    counter <- counter + 1
  }
  print(output_string)
}




remove_task <- function(index) {
#need to check if file exists
  if (file.exists(TASK_FILE)) {
    tasks <- readLines(TASK_FILE)
}  else {
    stop("Error. No such file exists")
  }
#check if task is empty
  if (length(tasks) == 0) {
    stop("no tasks found")
  }
#check if index is valid
  if (index >= 1 && index <= length(tasks)) {
    tasks <- tasks[-index]
}  else {
    stop("invalid syntax")
  }
#remove task at specified index
  
#rewrite and success message
   writeLines(tasks, TASK_FILE)
        
}



#main <- function(args) {

#  if (!is.null(args$add)) {
#    add_task(args$add)
#  } else if (args$list) {
#    tasks <- list_tasks()
#    print(tasks)
#  } else if (!is.null(args$remove)) {
#    remove_task(args$remove)
#  } else {
#    print("Use --help to get help on using this program")
#  }
#}


#if (sys.nframe() == 0) {

#  # main program, called via Rscript
#  parser <- ArgumentParser(description = "Command-line Todo List")
#  parser$add_argument("-a", "--add",
#                      help = "Add a new task")
#  parser$add_argument("-l", "--list",
#                      action = "store_true",
#                      help = "List all tasks")
#  parser$add_argument("-r", "--remove",
#                      help = "Remove a task by index")

#  args <- parser$parse_args()
#  main(args)
#}
