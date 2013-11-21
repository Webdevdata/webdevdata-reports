CSV_DIR=csv_out
WEBDEVDATA_DIR=$(abspath webdevdata-latest)
REPORT_DIR=output

CSV_GENERATORS=$(wildcard csv_generators/*)
CSVS=$(notdir ${CSV_GENERATORS})
REPORTS_GENERATORS=$(wildcard report_generators/*)
REPORTS=$(notdir ${REPORTS_GENERATORS})

all: $(WEBDEVDATA_DIR) reports

# Generate CSVS
csvs: $(CSVS)

$(CSVS): %: $(CSV_DIR)/%.csv

$(CSV_DIR)/%.csv: csv_generators/%
	mkdir -p $(CSV_DIR)
	rm -f $@
	csv_generators/$* $(WEBDEVDATA_DIR) > $@

# Generate reports
reports: csvs $(REPORTS)

$(REPORTS): %: $(REPORT_DIR)/%.md

$(REPORT_DIR)/%.md: report_generators/%
	mkdir -p $(REPORT_DIR)
	report_generators/$* > $@

# Data to extract
$(WEBDEVDATA_DIR):
	echo "Put your extracted webdevdata.org details in $(WEBDEVDATA_DIR)\n"\
	'or use $$WEBDEVDATA_DIR to specify where the data is'

clean:
	rm -rf $(CSV_DIR)
	rm -rf $(REPORT_DIR)

.PHONY: all clean csvs reports $(CSVS)

