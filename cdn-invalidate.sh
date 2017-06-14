#!/usr/bin/env bash

invalidation_batch_file="/tmp/batch.json"
distribution_id=E1QJ4170VEGN9O
cat << EOF > ${invalidation_batch_file}
{
  "Paths": {
    "Quantity": 1,
    "Items": ["/*"]
  },
  "CallerReference": "my-invalidation-$(date +%s)"
}
EOF
aws cloudfront create-invalidation  --distribution-id ${distribution_id} --invalidation-batch file://${invalidation_batch_file}
rm ${invalidation_batch_file} 