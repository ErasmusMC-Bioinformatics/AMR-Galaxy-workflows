#!/bin/bash
ec=0


# Check that unicycler workflows change datatype of trimmomatic
find . -iname "Unicycler*" | while read wf
do
	echo "Processing $wf"
	ftype=$(jq -r '.steps[] | select(.tool_id != null) | select(.tool_id | contains("trimmomatic")) | .post_job_actions.ChangeDatatypeActionfastq_out.action_arguments.newtype' < "$wf")
	if [[ "$ftype" != "fastqsanger" ]]; then
		echo "	Error in one unicycler wf: ensure output ftype of trimmomatic is fastqsanger"
		ec=1
	fi
done

# The others should be fastq
find Flye* Minimap* | while read wf
do
	echo "Processing $wf"
	ftype=$(jq -r '.steps[] | select(.tool_id != null) | select(.tool_id | contains("trimmomatic")) | .post_job_actions.ChangeDatatypeActionfastq_out.action_arguments.newtype' < "$wf")
	if [[ "$ftype" != "fastq" ]]; then
		echo "	Error in other wf: ensure output ftype of trimmomatic is fastqsanger"
		ec=1
	fi
done

# Check nametags
find . -iname "Unicycler*" | while read wf
do
	echo "Processing $wf"
	ftype=$(jq -r '.steps[] | select(.tool_id != null) | select(.tool_id | contains("trimmomatic")) | .post_job_actions.TagDatasetActionfastq_out.action_arguments.tags' < "$wf")
	if [[ "$ftype" != "name:unicycler" ]]; then
		echo "	Error in one unicycler wf: missing or incorrect nametag: $ftype"
		ec=1
	fi
done

# Check nametags
find . -iname "Flye*" | while read wf
do
	echo "Processing $wf"
	ftype=$(jq -r '.steps[] | select(.tool_id != null) | select(.tool_id | contains("trimmomatic")) | .post_job_actions.TagDatasetActionfastq_out.action_arguments.tags' < "$wf")
	if [[ "$ftype" != "name:flye" ]]; then
		echo "	Error in one flye wf: missing or incorrect nametag: $ftype"
		ec=1
	fi
done

find . -iname "Minimap*" | while read wf
do
	echo "Processing $wf"
	ftype=$(jq -r '.steps[] | select(.tool_id != null) | select(.tool_id | contains("trimmomatic")) | .post_job_actions.TagDatasetActionfastq_out.action_arguments.tags' < "$wf")
	if [[ "$ftype" != "name:miniasm" ]]; then
		echo "	Error in one minimap wf: missing or incorrect nametag: $ftype"
		ec=1
	fi
done


exit $ec
