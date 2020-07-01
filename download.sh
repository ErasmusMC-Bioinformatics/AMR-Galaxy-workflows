#!/bin/bash
. ~/arbeit/galaxy/parsec/.venv/bin/activate
versie=$1
parsec -g emc workflows get_workflows | \
	jq '.[] | select(.name | contains("'$versie'")) | [.id, .name] | @tsv' -r | \
	sed 's/\t/ > "/;s/$/.ga"/;s/^/parsec -g emc workflows export_workflow_dict /;s|/|-|g' | \
	bash
