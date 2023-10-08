#!/bin/bash
for k in  $(echo $(kubectl get pods -l app=frontend -n sunhwa -o jsonpath="{.items[*]}") | jq '[.metadata.name, .spec.containers[0].resources.requests]' | jq -s '.'| jq -c '.[]'); do
    echo ${k}
	name=$(echo ${k} | jq '.[0]');
	echo ${name}
	cpu=$(echo ${k} | jq '.[1].cpu');
	echo ${cpu}
	memory=$(echo ${k} | jq '.[1].memory');
    echo 'vpa_pod_request,pod='$name',cpu='$cpu',memory='$memory;
done
