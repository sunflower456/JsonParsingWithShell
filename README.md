https://github.com/influxdata/telegraf/blob/release-1.28/plugins/inputs/exec/README.md

output : 
vpa_pod_request,pod="frontend-5bdd9f855d-kzxfm",resource=cpu gauge=.30000000000000000000i
vpa_pod_request,pod="frontend-5bdd9f855d-kzxfm",resource=memory gauge=262144000i
vpa_pod_request,pod="frontend-5bdd9f855d-wrhxb",resource=cpu gauge=.30000000000000000000i
vpa_pod_request,pod="frontend-5bdd9f855d-wrhxb",resource=memory gauge=262144000i
vpa_target_info,vpa_name=frontend-vpa,resource=cpu,recommendation=lowerBound,unit=cores gauge=.04800000000000000000i
vpa_target_info,vpa_name=frontend-vpa,resource=cpu,recommendation=target,unit=cores gauge=.41000000000000000000i
vpa_target_info,vpa_name=frontend-vpa,resource=cpu,recommendation=uncappedTarget,unit=cores gauge=.41000000000000000000i
vpa_target_info,vpa_name=frontend-vpa,resource=cpu,recommendation=upperBound,unit=cores gauge=.94900000000000000000i
vpa_target_info,vpa_name=frontend-vpa,resource=memory,recommendation=upperBound,unit=bytes gauge=2005482902i
vpa_target_info,vpa_name=frontend-vpa,resource=memory,recommendation=target,unit=bytes gauge=262144000i
vpa_target_info,vpa_name=frontend-vpa,resource=memory,recommendation=lowerBound,unit=bytes gauge=262144000i
vpa_target_info,vpa_name=frontend-vpa,resource=memory,recommendation=uncappedTarget,unit=bytes gauge=262144000i
vpa_target_info,vpa_name=frontend-vpa,lowerBoundCpu=.04800000000000000000,lowerBoundMemory=262144000,targetCpu=.41000000000000000000,targetMemory=262144000,uncappedTargetCpu=.41000000000000000000,uncappedTargetMemory=262144000,upperBoundCpu=.94900000000000000000,upperBoundMemory=2005482902
