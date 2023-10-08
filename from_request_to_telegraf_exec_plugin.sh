#!/bin/bash
for k in  $(echo $(kubectl get pods -l app=frontend -n sunhwa -o jsonpath="{.items[*]}") | jq '[.metadata.name, .spec.containers[0].resources.requests]' | jq -s '.'| jq -c '.[]'); do
        name=$(echo ${k} | jq '.[0]');
        cpu=$(echo ${k} | jq '.[1].cpu');
        if [[ ${cpu} == *"m"* ]]; then
                cpuCore=$(echo $cpu | sed -e "s/m//g")
                cpuCore=$(echo $cpuCore | sed -e "s/"\"//g"")
                cpuNum=$(echo $((cpuCore)))
                core=1000
                cpuresult=$(bc -l <<< $((cpuNum))/$((core)))

        fi
        echo 'vpa_pod_request,pod='$name',resource=cpu gauge='$cpuresult'i';
        memory=$(echo ${k} | jq '.[1].memory');
        if [[ ${memory} == *"k"* ]]; then
                mem=$(echo $memory | sed -e "s/k//g")
                mem=$(echo $mem | sed -e "s/"\"//g"")
                memBytes=$(echo $((mem)))
                bytes=1000
                memresult=$(bc -l <<< $((memBytes))/$((bytes)))
        fi
        echo 'vpa_pod_request,pod='$name',resource=memory gauge='$memresult'i';
done
name='frontend-vpa';
lowerBoundCpu=$(echo $(kubectl get vpa frontend-vpa -n sunhwa -o jsonpath="{.status.recommendation.containerRecommendations}") | jq '.[0].lowerBound.cpu');
lowerBoundMemory=$(echo $(kubectl get vpa frontend-vpa -n sunhwa -o jsonpath="{.status.recommendation.containerRecommendations}")  | jq '.[0].lowerBound.memory');
targetCpu=$(echo $(kubectl get vpa frontend-vpa -n sunhwa -o jsonpath="{.status.recommendation.containerRecommendations}") | jq '.[0].target.cpu');
targetMemory=$(echo $(kubectl get vpa frontend-vpa  -n sunhwa -o jsonpath="{.status.recommendation.containerRecommendations}") | jq '.[0].target.memory');
uncappedTargetCpu=$(echo $(kubectl get vpa frontend-vpa  -n sunhwa -o jsonpath="{.status.recommendation.containerRecommendations}")  | jq '.[0].uncappedTarget.cpu');
uncappedTargetMemory=$(echo $(kubectl get vpa frontend-vpa -n sunhwa -o jsonpath="{.status.recommendation.containerRecommendations}")  | jq '.[0].uncappedTarget.memory');
upperBoundCpu=$(echo $(kubectl get vpa frontend-vpa  -n sunhwa -o jsonpath="{.status.recommendation.containerRecommendations}") | jq '.[0].upperBound.cpu');
upperBoundMemory=$(echo $(kubectl get vpa frontend-vpa -n sunhwa -o jsonpath="{.status.recommendation.containerRecommendations}")  | jq '.[0].upperBound.memory');
echo 'vpa_target_info,vpa_name='${name}',lowerBoundCpu='${lowerBoundCpu}',lowerBoundMemory='${lowerBoundMemory}',targetCpu='${targetCpu}',targetMemory='${targetMemory}',uncappedTargetCpu='${uncappedTargetCpu}',uncappedTargetMemory='${uncappedTargetMemory}',upperBoundCpu='${upperBoundCpu}',upperBoundMemory='${upperBoundMemory};
echo $(kubectl get pods -l app=frontend -n sunhwa -o jsonpath="{.items[*]}") | jq '[.metadata.name, .spec.containers[0].resources.requests]'

