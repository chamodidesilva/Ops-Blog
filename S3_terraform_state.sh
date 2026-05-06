#!/bin/bash

set -e

bucket_name="ops-blog-terraform-state-bucket"

aws s3api create-bucket \
    --bucket $bucket_name \
    --region us-east-1

aws s3api put-bucket-versioning \
    --bucket $bucket_name \
    --versioning-configuration Status=Enabled

aws s3api put-bucket-lifecycle-configuration \
    --bucket $bucket_name \
    --lifecycle-configuration '{
        "Rules": [
            {
                "ID": "NonCurrentVersionDeletion",
                "Status": "Enabled",
                "Filter": {
                    "Prefix": ""
                },
                "NoncurrentVersionExpiration": {
                    "NoncurrentDays": 1
                },
                "AbortIncompleteMultipartUpload": {
                    "DaysAfterInitiation": 1
                }
            }
        ]
    }'

aws s3api put-public-access-block \
    --bucket $bucket_name \
    --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"






