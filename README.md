# Scripts to generate reports from webdevdata.org

This repository contains the scripts to:
 * Generate CSV files with information to analyze from webdevdata.org
 * Generate reports using such CSVs in Markdown

## Configuration

You must point ```make``` to the right path to find the webdevdata.org
data to analyse. This is done with the following:

 * ```WEBDEVDATA_DIR``` (default: _webdevdata-latest_): Directory
   containing the information from webdevdata.org

You can do two things:

 1. Set ```WEBDEVDATA_DIR``` when running make. e.g.: ```make
    WEBDEVDATA_DIR=~/Downloads/webdevdata.org-2013-10-30-231036```
 2. Link to the default ```WEBDEVDATA_DIR```. e.g.: ```ln -s
    ~/Downloads/webdevdata.org-2013-10-30-231036 webdevdata-latest```

## CSV generators

We generate CSV files with data from webdevdata.org in order to
analise the information.

Scripts can be found in the ```csv_generators``` direcotry.

Running ```make csvs``` will run each script in the directory and store
the output in a CSV file inside the ```csv_out``` directory.

## Report generators

We generate Markdown (.md extension) files with data from webdevdata.org in
order to analise the information.

Scripts can be found in the ```report_generators``` direcotry.

Running ```make``` will run each script in the directory and store
the output in a Markdown file inside the ```output``` directory.

## Dependencies

We try to keep project dependencies to a minimum. Current dependencies
are:

 * [webdevdata-tools][wdd-tools] to generate CSVs
 * [csvkit][csvkit] to process CSV files since it handles things such as
   CSV rows that take more than one line in the CSV files due to
   ```\n``` characters in quoted values
 * [GNU/Parallel][parallel] to assist generating CSVs from data

Other command-line tools that are used and are most probably already
available in your system such as: ```sort```, ```make```, ```awk```, ```grep```
and ```iconv```.

## Why this setup?

This setup consists mainly of:

 1. shell scripts to generate CSVs and reports: the reason being that
    scripts can be re-run to generate new reports when new data is
    published in webdevdata.org.
 2. Using a Makefile: this way we just need to run one single command to
    generate the reports and when developing the scripts,  we can run
    ```make``` to regenerate only CVS and Markdown for which the generator
    file has changed.

## Caveats

 * HTMLs from webdevdata.org use a mix of character encodings. This
   results in a mix of character encodings used in the CSVs, which
   cannot be processed by some tools that require UTF8 such as
   the csvkit tools. To get around that we are using ```iconv``` to get
   a consistent UTF8 file, but it means some characters in other encodings
   are lost.

[wdd-tools]: http://github.com/webdevdata/webdevdata-tools
[parallel]: http://www.gnu.org/software/parallel/
[csvkit]: http://csvkit.readthedocs.org/en/latest/
