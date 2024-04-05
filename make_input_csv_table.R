#!/usr/bin/Rscript
args <- commandArgs(trailingOnly = TRUE)

# install pacman package and load the other packages
if (!require("pacman", quietly = TRUE))
    install.packages("pacman",)

pacman::p_load(dplyr, stringr, readr, tidyr)

# Directories
# create files folder
mainDir <- getwd()
subDir <- "files"
dir.create(file.path(mainDir, subDir), showWarnings = FALSE)
# get the sequence directories
folder_path <- args[1] 
dir_names <- dir(folder_path, full.names = T)


# paths to the reads
file_paths_1 <- list.files(dir_names, recursive = T, pattern = "1.fastq.gz", full.names = T) %>% tibble(read1 = .)
file_paths_1 <- file_paths_1 %>% mutate(seq_name_1 = basename(read1),
                                        sample_id = str_remove(seq_name_1, "_1.fastq.gz"))

file_paths_2 <- list.files(dir_names, recursive = T, pattern = "2.fastq.gz", full.names = T) %>% tibble(read2 = .)
file_paths_2 <- file_paths_2 %>% mutate(seq_name_2 = basename(read2),
                                        sample_id = str_remove(seq_name_2, "_2.fastq.gz"))

# put all together
df_dir <- file_paths_1 %>% 
            full_join(file_paths_2, by =  "sample_id") %>% 
            relocate(sample_id , .before = 1) %>%
            relocate(seq_name_1 , .after = 1) %>%
            relocate(seq_name_2 , .after = 2)

# drop NAs
df_dir_no_na <- df_dir %>% drop_na()
# only NAs (if you are interested)
df_dir_na <- df_dir %>% filter(if_any(everything(), is.na))

write_csv(df_dir_no_na, "files/sequences.csv")
write_csv(df_dir_na, "files/sequences_na.csv")


# USE THIS CSV AS THE INPUT OF THE NEXTFLOW PIPELINE

