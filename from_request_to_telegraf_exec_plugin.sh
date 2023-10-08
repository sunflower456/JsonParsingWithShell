#!/bin/bash

for k in  $(echo $(kubectl get pods -l app=frontend -n sunhwa -o jsonpath="{.items[*]}") | jq '[.metadata.name, .spec.containers[0].resources.requests]' | jq -s '.'| jq -c '.[]'); do
        name=$(echo ${k} | jq '.[0]');
	cpu=$(echo ${k} | jq '.[1].cpu');
	
        if [[ ${cpu} == *"m"* ]]; then
                cpuCore=$(echo $cpu | sed -e "s/m//g")
                cpuCore=$(echo $cpuCore | sed 's/"//g')
                cpuNum=$(echo $((cpuCore)))
                core=1000
                cpuresult=$(bc -l <<< $((cpuNum))/$((core)))

        fi
        echo 'vpa_pod_request,pod='$name',resource=cpu gauge='$cpuresult ;
        memory=$(echo ${k} | jq '.[1].memory');
	if [[ ${memory} == *"k"* ]]; then
	        mem=$(echo $memory | sed -e "s/k//g")
                mem=$(echo $mem | sed 's/"//g')
                memBytes=$(echo $((mem)))
                bytes=1000
                memresult=$(bc -l <<< $((memBytes))*$((bytes)))
	fi
        echo 'vpa_pod_request,pod='$name',resource=memory gauge='$memresult ;
done
name='frontend-vpa';


lowerBoundCpu=$(echo $(kubectl get vpa frontend-vpa -n sunhwa -o jsonpath="{.status.recommendation.containerRecommendations}") | jq '.[0].lowerBound.cpu' | sed 's/""//g');
targetCpu=$(echo $(kubectl get vpa frontend-vpa -n sunhwa -o jsonpath="{.status.recommendation.containerRecommendations}") | jq '.[0].target.cpu' | sed 's/""//g');
uncappedTargetCpu=$(echo $(kubectl get vpa frontend-vpa  -n sunhwa -o jsonpath="{.status.recommendation.containerRecommendations}")  | jq '.[0].uncappedTarget.cpu' | sed 's/""//g');
upperBoundCpu=$(echo $(kubectl get vpa frontend-vpa  -n sunhwa -o jsonpath="{.status.recommendation.containerRecommendations}") | jq '.[0].upperBound.cpu' | sed 's/""//g');
upperBoundMemory=$(echo $(kubectl get vpa frontend-vpa -n sunhwa -o jsonpath="{.status.recommendation.containerRecommendations}")  | jq '.[0].upperBound.memory' | sed 's/""//g');
targetMemory=$(echo $(kubectl get vpa frontend-vpa  -n sunhwa -o jsonpath="{.status.recommendation.containerRecommendations}") | jq '.[0].target.memory' | sed 's/""//g');
lowerBoundMemory=$(echo $(kubectl get vpa frontend-vpa -n sunhwa -o jsonpath="{.status.recommendation.containerRecommendations}")  | jq '.[0].lowerBound.memory' | sed 's/""//g');
uncappedTargetMemory=$(echo $(kubectl get vpa frontend-vpa -n sunhwa -o jsonpath="{.status.recommendation.containerRecommendations}")  | jq '.[0].uncappedTarget.memory' | sed 's/""//g');




lowerBoundCpu=$(echo $(kubectl get vpa frontend-vpa -n sunhwa -o jsonpath="{.status.recommendation.containerRecommendations}") | jq '.[0].lowerBound.cpu');
if [[ ${lowerBoundCpu} == *"m"* ]]; then
  cpuCore=$(echo ${lowerBoundCpu} | sed -e "s/m//g")
  cpuCore=$(echo $cpuCore | sed 's/"//g')
  cpuNum=$(echo $((cpuCore)))
  core=1000
  lowerBoundCpu=$(bc -l <<< $((cpuNum))/$((core)))
else
  lowerBoundCpu=$(echo ${lowerBoundCpu} | sed 's/"//g')
  lowerBoundCpu=$((lowerBoundCpu))
fi
echo 'vpa_target_info,vpa_name='${name}',resource=cpu,recommendation=lowerBound,unit=cores gauge='${lowerBoundCpu} ;

targetCpu=$(echo $(kubectl get vpa frontend-vpa -n sunhwa -o jsonpath="{.status.recommendation.containerRecommendations}") | jq '.[0].target.cpu');
if [[ ${targetCpu} == *"m"* ]]; then
  cpuCore=$(echo ${targetCpu} | sed -e "s/m//g")
  cpuCore=$(echo $cpuCore | sed 's/"//g')
  cpuNum=$(echo $((cpuCore)))
  core=1000
  targetCpu=$(bc -l <<< $((cpuNum))/$((core)))
else
  targetCpu=$(echo ${targetCpu} | sed 's/"//g')
  targetCpu=$((targetCpu))
fi
echo 'vpa_target_info,vpa_name='${name}',resource=cpu,recommendation=target,unit=cores gauge='${targetCpu} ;

uncappedTargetCpu=$(echo $(kubectl get vpa frontend-vpa  -n sunhwa -o jsonpath="{.status.recommendation.containerRecommendations}")  | jq '.[0].uncappedTarget.cpu' );
if [[ ${uncappedTargetCpu} == *"m"* ]]; then
  cpuCore=$(echo ${uncappedTargetCpu} | sed -e "s/m//g")
  cpuCore=$(echo $cpuCore | sed 's/"//g')
  cpuNum=$(echo $((cpuCore)))
  core=1000
  uncappedTargetCpu=$(bc -l <<< $((cpuNum))/$((core)))
else
  uncappedTargetCpu=$(echo ${uncappedTargetCpu} | sed 's/"//g')
  uncappedTargetCpu=$((uncappedTargetCpu))
fi
echo 'vpa_target_info,vpa_name='${name}',resource=cpu,recommendation=uncappedTarget,unit=cores gauge='${uncappedTargetCpu} ;


upperBoundCpu=$(echo $(kubectl get vpa frontend-vpa  -n sunhwa -o jsonpath="{.status.recommendation.containerRecommendations}") | jq '.[0].upperBound.cpu');
if [[ ${upperBoundCpu} == *"m"* ]]; then
  cpuCore=$(echo ${upperBoundCpu} | sed -e "s/m//g")
  cpuCore=$(echo $cpuCore | sed 's/"//g')
  cpuNum=$(echo $((cpuCore)))
  core=1000
  upperBoundCpu=$(bc -l <<< $((cpuNum))/$((core)))
else
  upperBoundCpu=$(echo ${upperBoundCpu} | sed 's/"//g')
  upperBoundCpu=$((upperBoundCpu))
fi
echo 'vpa_target_info,vpa_name='${name}',resource=cpu,recommendation=upperBound,unit=cores gauge='${upperBoundCpu} ;


upperBoundMemory=$(echo $(kubectl get vpa frontend-vpa -n sunhwa -o jsonpath="{.status.recommendation.containerRecommendations}")  | jq '.[0].upperBound.memory');
if [[ ${upperBoundMemory} == *"k"* ]]; then
  memBytes=$(echo ${upperBoundMemory} | sed -e "s/k//g")
  memBytes=$(echo $memBytes | sed 's/"//g')
  memNum=$(echo $((memBytes)))
  bytes=1000
  upperBoundMemory=$(bc -l <<< $((memNum))*$((bytes)))
else
  upperBoundMemory=$(echo ${upperBoundMemory} | sed 's/"//g')
  upperBoundMemory=$((upperBoundMemory))
fi
echo 'vpa_target_info,vpa_name='${name}',resource=memory,recommendation=upperBound,unit=bytes gauge='${upperBoundMemory} ;

targetMemory=$(echo $(kubectl get vpa frontend-vpa  -n sunhwa -o jsonpath="{.status.recommendation.containerRecommendations}") | jq '.[0].target.memory');
if [[ ${targetMemory} == *"k"* ]]; then
  memBytes=$(echo ${targetMemory} | sed -e "s/k//g")
  memBytes=$(echo $memBytes | sed 's/"//g')
  memNum=$(echo $((memBytes)))
  bytes=1000
  targetMemory=$(bc -l <<< $((memNum))*$((bytes)))
else
  targetMemory=$(echo ${targetMemory} | sed 's/"//g')
  targetMemory=$((targetMemory))
fi
echo 'vpa_target_info,vpa_name='${name}',resource=memory,recommendation=target,unit=bytes gauge='${targetMemory} ;


lowerBoundMemory=$(echo $(kubectl get vpa frontend-vpa -n sunhwa -o jsonpath="{.status.recommendation.containerRecommendations}")  | jq '.[0].lowerBound.memory');
if [[ ${lowerBoundMemory} == *"k"* ]]; then
  memBytes=$(echo ${lowerBoundMemory} | sed -e "s/k//g")
  memBytes=$(echo $memBytes | sed 's/"//g')
  memNum=$(echo $((memBytes)))
  bytes=1000
  lowerBoundMemory=$(bc -l <<< $((memNum))*$((bytes)))
else
  lowerBoundMemory=$(echo ${lowerBoundMemory} | sed 's/"//g')
  lowerBoundMemory=$((lowerBoundMemory))
fi
echo 'vpa_target_info,vpa_name='${name}',resource=memory,recommendation=lowerBound,unit=bytes gauge='${lowerBoundMemory} ;

uncappedTargetMemory=$(echo $(kubectl get vpa frontend-vpa -n sunhwa -o jsonpath="{.status.recommendation.containerRecommendations}")  | jq '.[0].uncappedTarget.memory');
if [[ ${uncappedTargetMemory} == *"k"* ]]; then
  memBytes=$(echo ${uncappedTargetMemory} | sed -e "s/k//g")
  memBytes=$(echo $memBytes | sed 's/"//g')
  memNum=$(echo $((memBytes)))
  bytes=1000
  uncappedTargetMemory=$(bc -l <<< $((memNum))*$((bytes)))
else
  uncappedTargetMemory=$(echo ${uncappedTargetMemory} | sed 's/"//g')
  uncappedTargetMemory=$((uncappedTargetMemory))
fi
echo 'vpa_target_info,vpa_name='${name}',resource=memory,recommendation=uncappedTarget,unit=bytes gauge='${uncappedTargetMemory} ;
