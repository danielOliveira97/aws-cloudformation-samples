
#!/bin/bash
# SETUP: add to local git config:
# git config --local credential.helper '!~/bin/awsCredentialHelperOSX AWS_PROFILE'
# replace AWS_PROFILE with the relevant profile name, replace "~/bin/" with path to this file
aws_profile="$1"
shift
# get aws_access_key_id for aws_profile
aws_access_key_id=$(sed -n '/^[ \t]*\[${aws_profile}\]/,/\[/s/^[ \t]*aws_access_key_id[ \t]*=[ \t]*//p' ~/.aws/credentials)
security -q delete-internet-password -a "${aws_access_key_id}" >/dev/null 2>&1
/usr/local/bin/aws --profile "${aws_profile}" codecommit credential-helper $@
