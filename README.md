# Nextflow Metagenomic Analysis Pipeline for Viruses and Prokaryotes (under construction)

This repository contains a comprehensive metagenomic analysis pipeline designed for the study of viruses and prokaryotes in environmental or human/animal samples. The pipeline is implemented in Nextflow, making it scalable, reproducible, and easy to deploy on various computing environments.

- [Nextflow pipeline]([https://github.com/ricrocha82/metagenomics/tree/main/nextflow](https://www.nextflow.io)): pre-processing samples, R/Python for statistical analysis
- Command line for each processing steps are described in below.


## Features
- **Modular Design:** The pipeline is modularized for flexibility, allowing users to customize individual steps based on their specific requirements.

- **Support for Viral and Prokaryotic Analysis:** The pipeline supports the analysis of both viral and prokaryotic sequences, enabling comprehensive metagenomic studies.

- **Integration of Bioinformatics Tools:** Various bioinformatics tools such as bbmap, bbduk, and metaspades (...) are seamlessly integrated into the pipeline, providing a robust analytical framework.

- **Quality Control and Contamination Removal:** The pipeline includes quality control steps to filter low-quality reads and remove contaminants, ensuring the reliability of downstream analyses.

- **Assembly:** Metagenomic assembly is performed using SPAdes

- (...)

## Getting Started

### Install required software

**Install Dependencies:** Ensure that Nextflow is installed on your system. Additionally, install any required dependencies specified in the .yml files.

You can install all the tools at once (not recommended) 

You can also use mamba instead of conda
```bash
conda install -c conda-forge -c bioconda -c agbiome fastqc multiqc bbtools
conda create r-essentials r-base 
conda install -c bioconda nextflow
```

or create conda environments for each step 

```bash
conda create -n quality_control -c conda-forge -c bioconda -c agbiome fastqc multiqc bbtools
conda create -n r_env r-essentials r-base
conda create -n nextflow -c bioconda nextflow
```

or you can use the [YML files](https://github.com/ricrocha82/metagenomics/tree/main/config_files) (recommended - version control)

```bash
conda env create -f quality_control.yaml
conda env create -f nextflow.yaml
```

To run the pipeline, follow these steps:

**Configure Input Data:** Prepare your input data by organizing raw sequencing reads in the appropriate directory structure.

The **input** is a [CSV table](https://github.com/ricrocha82/nextflow_metaG/blob/main/sequences.csv):

column names = sample_id /	seq_name_1 /	seq_name_2	/ read1 / read2


![image](https://github.com/ricrocha82/nextflow_metaG/assets/46669010/57c11f16-8f36-4f53-bf94-eb7107274b4b)

Running the [code](https://github.com/ricrocha82/nextflow_metaG/blob/main/make_input_csv_table.R) below can help you make the input table.

NOTE: The files should be organized this way:

```bash
/path/to/the/sequences/
├── SRRxxxxxx
│   ├── SRRxxxxxx_1.fastq.gz
│   └── SRRxxxxxx_2.fastq.gz
├── SRRxxxxxx
│   ├── SRRxxxxxx_1.fastq.gz
│   └── SRRxxxxxx_2.fastq.gz
...
```

Go to the directory where you want to run the Nextflow pipeline and store the outputs. Then run

```bash
Rscript 0.make_input_csv_table.R path/where/the/sequences/are/
```

**Run the Pipeline:** Execute the Nextflow command to run the pipeline:

```bash
nextflow run /path/to/the/directory/nf_metagen.nf -profile conda
```

The output should be something like this:

```bash
/directory/nextflow_metaG
├── nextflow.config
├── nf_metagen.nf
├── config_files
│   ├── assembly_config.yml
│   ├── quality_control_config.yml
│   └── nextflow_config.yml
├── 1.qc
│   ├── fastqc_SRR6xxx_logs
│   │   ├── SRR6xxx_1_fastqc.html
│   │   ├── SRR6xxx_1_fastqc.zip
│   │   ├── SRR6xxx_2_fastqc.html
│   │   └── SRR6xxx_2_fastqc.zip
...
│   └── multiqc_report.html
├── 2.clean
│   ├── SRR6xxx_R1_clean.fastq.gz
│   ├── SSRR6xxx_R2_clean.fastq.gz
│   ├── SRR6xxx_singletons_clean.fastq.gz
│   ├── SRR6xxx_R1_clean.fastq.gz
│   ├── SRR6xxx_R2_clean.fastq.gz
│   ├── SRR6xxx_singletons_clean.fastq.gz
│    ...
├── 2.trimm
│   ├── SRR6xxx_R1_adapters.fastq.gz
│   ├── SRR6xxx_R1_phix.fastq.gz
│   ├── SRR6743909_R1_qc.fastq.gz
│   ├── SRR6xxx_R2_adapters.fastq.gz
│   ├── SRR6xxx_R2_phix.fastq.gz
│   ├── SRR6xxx_R2_qc.fastq.gz
│   ├── SRR6xxx_singletons_adapters.fastq.gz
│   ├── SRR6xxx_singletons_phix.fastq.gz
│    ...
├── 3.assembly
│   ├── SRR6xxx_contigs.fasta
│   ├── SRR6xxx_scaffolds.fasta
│   ...
├── files
│   ├── sequences.csv
│   └── sequences_na.csv
└── log_nextflow
│   ├── nf_report.html
│    └── nf_timeline.html
...
```



### Contributions

Contributions to this pipeline are welcome! If you encounter any issues, have suggestions for improvements, or would like to add new features, please open an issue or submit a pull request.

### License
This project is licensed under the MIT License.
