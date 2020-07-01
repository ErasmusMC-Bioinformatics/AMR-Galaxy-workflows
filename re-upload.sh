#!/bin/bash
. ~/arbeit/galaxy/parsec/.venv/bin/activate
versie=$1
for wf in *$versie.ga; do
	echo Uploading $wf
	parsec -g emc workflows import_workflow_from_local_path "$wf"
done
