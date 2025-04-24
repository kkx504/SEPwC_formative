#!/usr/bin/env Rscript
suppressPackageStartupMessages({
  library(argparse)
})


library(lintr)
options(lintr.linters = lintr::linters_with_defaults(
  line_length_linter = NULL, #because line 14 needs to be longer than the default 80
  return_linter = NULL #because in my list_tasks function it told me to not explictly use return but when i did the test failed
))


options(python_cmd = "C:/Users/Izzy/AppData/Local/Programs/Python/Python313/python.exe")


TASK_FILE <- ".tasks.txt" #nolint

add_task <- function(task) {
  write(task, file = TASK_FILE, append = TRUE) #writing a task into the file TASK_FILE, appending so it adds not overwrites
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
      output_string <- paste0(output_string, "\n") #only when the counter is less than the number of items will there be a new line
    counter <- counter + 1
  }
  return(output_string)
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
  #check if index is valid (in the amount of items there are in the list)
  if (index >= 1 && index <= length(tasks)) {
    tasks <- tasks[-index] #removing the index
  }  else {
    stop("invalid index")
  }
  #rewrite
  writeLines(tasks, TASK_FILE)
}



main <- function(args) {
  if (!is.null(args$add)) {
    add_task(args$add)
  } else if (args$list) {
    tasks <- list_tasks()
    print(tasks)
  } else if (!is.null(args$remove)) {
    remove_task(args$remove)
    print("Item removed")
  } else {
    print("Use --help to get help on using this program")
  }
}


if (sys.nframe() == 0) {
  # main program, called via Rscript
  parser <- ArgumentParser(description = "Command-line Todo List")
  parser$add_argument("-a", "--add",
                      help = "Add a new task")
  parser$add_argument("-l", "--list",
                      action = "store_true",
                      help = "List all tasks")
  parser$add_argument("-r", "--remove",
                      help = "Remove a task by index")
  args <- parser$parse_args()
  main(args)
}
